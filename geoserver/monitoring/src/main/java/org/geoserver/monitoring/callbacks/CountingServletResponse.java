package org.geoserver.monitoring.callbacks;

import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;

/**
 * A {@link ServletOutputStream} decorator that informs how many bytes have been written to the
 * response stream
 * 
 */
public class CountingServletResponse extends HttpServletResponseWrapper {

    /**
     * OutputStream decorator that counts the written bytes
     */
    private static class CountingOutputStream extends ServletOutputStream {

        private long writeCount;

        private final OutputStream subject;

        public CountingOutputStream(final OutputStream subject) {
            this.subject = subject;
        }

        /**
         * @return the number of bytes written so far
         */
        public long getWrittenCount() {
            return writeCount;
        }

        @Override
        public void write(int b) throws IOException {
            subject.write(b);
            ++writeCount;
        }

        @Override
        public void write(byte b[]) throws IOException {
            subject.write(b);
            writeCount += b.length;
        }

        @Override
        public void write(byte b[], int off, int len) throws IOException {
            subject.write(b, off, len);
            writeCount += len;
        }

        @Override
        public void flush() throws IOException {
            subject.flush();
        }

        @Override
        public void close() throws IOException {
            subject.close();
        }
    }

    private CountingOutputStream countingOut;

    public CountingServletResponse(final HttpServletResponse subject) {
        super(subject);
    }

    public long getWrittenCount() {
        return countingOut == null ? 0 : countingOut.getWrittenCount();
    }

    @Override
    public ServletOutputStream getOutputStream() throws IOException {
        if (countingOut == null) {
            ServletOutputStream original = super.getOutputStream();
            countingOut = new CountingOutputStream(original);
        }
        return countingOut;
    }
}
