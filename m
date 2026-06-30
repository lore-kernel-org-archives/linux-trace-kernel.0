Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A54533B9920;
	Tue, 30 Jun 2026 20:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782852291; cv=none; b=McFExUdrtNVadbkqO7UfvLwohD7SoTNryQo+HMayyIjXvP9ewPuRoF7NMX9wYvu5Tj4A+86h5oHbVENmzwomMRcQyRCWN6zSLtpch5aRbUGyu9QxWGBqssQSPSBLUabG+dQQRgqTDgscozhCLRquCFXq+NxrTTj+EwcgkOIVbvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782852291; c=relaxed/simple;
	bh=okUmui3VnSblvrHsA0uQ2PWyrXWsJn9ztW+KVwyEb8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QiV3eu0b0zNxZZ/RUBObkWnE8s0ifwk2DS9MZ+sGRsgZxPmPlSCoMXtkAVxxYJK754p/qaezZUomnNOdPwMMY31bplrXCfw0fXbHg2aCQ5sJhCaFRgMy/F/I46uQjy7ysF4WzLwPj6tJkFsqQXm3XiyS2sdQgqcYI9tCRrqoBEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 9EEE940114;
	Tue, 30 Jun 2026 20:44:41 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id 992DC20010;
	Tue, 30 Jun 2026 20:44:39 +0000 (UTC)
Date: Tue, 30 Jun 2026 16:44:39 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Martin Kaiser <martin@kaiser.cx>
Cc: Frank Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, imx@lists.linux.dev,
 dmaengine@vger.kernel.org
Subject: Re: [PATCH] fsl-edma: tracing: no ptr dereference during log output
Message-ID: <20260630164439.51e61b71@gandalf.local.home>
In-Reply-To: <20260630160544.4211ae88@gandalf.local.home>
References: <20260630200022.1826420-1-martin@kaiser.cx>
	<20260630160544.4211ae88@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 992DC20010
X-Stat-Signature: escraam5swnpxnqpeejqfpqgu6pioyan
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+gSQo04mtg4lddc8VRqnjAeGh6sOoXIKg=
X-HE-Tag: 1782852279-513083
X-HE-Meta: U2FsdGVkX19y2SwDl4vlu3cXx7MA/npPcPGdgyjL0EyfSoivuVG5l3o2BVIlfOLzkWK4chTTmGSvRJaygmOiqaCcJd6jFIKCY8EHjJbMe733rUj/YW+32/NGWTM9yD3IMU2B59Mw4P9HsYL3OkpdDvlUhc33H/RDGJJWUDlMlGY8Oqp51LTcMa/Um7L2VJhWUjhfX/DEz3urGiCr4oArsKs1Hhpj+1H84pSZq2TgMgGqVr9aO/xM4IGkGWZJcGM9VoizH3OzDWLh9htGEwmb2FYmVB0CKwLP4JaplJfyoaeaGmUgQ8awxOV+zBkG7aIjl96Qy8aFPIY9RmYv2seXBpH/EoBUzqCnjakYfDwXhEU3eyaO0OOUX8jZawZVyFxF

On Tue, 30 Jun 2026 16:05:44 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> >  	TP_printk("offset %08x: value %08x",
> > -		(u32)(__entry->addr - __entry->edma->membase), __entry->value)
> > +		(u32)(__entry->addr - __entry->membase), __entry->value)  
> 
> Hmm, I think I should update the TP_printk checks at boot to cover this too.

I created the following to catch this:

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c46e623e7e0d..2da3c02bea54 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -400,10 +400,37 @@ static bool process_string(const char *fmt, int len, struct trace_event_call *ca
 	return true;
 }
 
+static void test_double_dereference(const char *str, int len,
+				    struct trace_event_call *call)
+{
+	const char *ptr;
+	const char *end = str + len;
+
+	ptr = strstr(str, "REC->");
+
+	while (ptr && ptr < end) {
+
+		ptr += 5;
+		for (; ptr < end; ptr++) {
+			if (ptr[0] == '-' && ptr[1] == '>') {
+				WARN_ONCE(1, "Event %s has double dereference in TP_printk: %*s\n",
+					  trace_event_name(call), len, str);
+				return;
+			}
+			if (!isalnum(*ptr) && *ptr != '_')
+				break;
+		}
+
+		ptr = strstr(ptr, "REC->");
+	}
+}
+
 static void handle_dereference_arg(const char *arg_str, u64 string_flags, int len,
 				   u64 *dereference_flags, int arg,
 				   struct trace_event_call *call)
 {
+	test_double_dereference(arg_str, len, call);
+
 	if (string_flags & (1ULL << arg)) {
 		if (process_string(arg_str, len, call))
 			*dereference_flags &= ~(1ULL << arg);

Enabled this event to see if it would trigger, but instead it found *another* BUG!

[    0.719012][    T0] ------------[ cut here ]------------
[    0.720850][    T0] Event ufshcd_exception_event has double dereference in TP_printk: dev_name(REC->hba->dev), REC->status
[    0.724646][    T0] WARNING: kernel/trace/trace_events.c:416 at handle_dereference_arg+0x342/0x5a0, CPU#0: swapper/0/0


I'll go make a fix for the ufshcd_exception_event event, and then I will
definitely add this patch to make sure this bug isn't in other places.

-- Steve
