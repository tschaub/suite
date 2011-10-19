package org.opengeo.data.importer.transform;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import junit.framework.TestCase;
import net.sf.json.JSONObject;

/**
 *
 * @author Ian Schneider <ischneider@opengeo.org>
 */
public class DateFormatTransformTest extends TransformTestSupport {
    
    public DateFormatTransformTest() {
    }

    public void testTransformSuccess() throws ParseException {
        String NOT_USED = null;
        DateFormatTransform transform = new DateFormatTransform("not used", NOT_USED);

        Date now = new Date();
        for (String f : DateFormatTransform.PATTERNS) {
            SimpleDateFormat fmt = new SimpleDateFormat(f);
            fmt.setTimeZone(DateFormatTransform.UTC_TZ);
            Date expected = fmt.parse(fmt.format(now));
            Date parsed = transform.parseDate(fmt.format(now));
            assertEquals(expected, parsed);
        }
    }

    public void testTransformSuccessCustomFormat() throws ParseException {
        String customFormat = "yyyy-MM-dd'X'00";
        DateFormatTransform transform = new DateFormatTransform("not used", customFormat);

        Date now = new Date();
        SimpleDateFormat fmt = new SimpleDateFormat(customFormat);
        fmt.setTimeZone(DateFormatTransform.UTC_TZ);
        Date expected = fmt.parse(fmt.format(now));
        Date parsed = transform.parseDate(fmt.format(now));
        assertEquals(expected, parsed);
    }
    
    public void testJSON() throws Exception {
        doJSONTest(new DateFormatTransform("foo", null));
        doJSONTest(new DateFormatTransform("foo", "yyyy-MM-dd"));
    }
}
