Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404C5376BC5
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 20:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774556309; cv=none; b=FwXhASgwLUCtIpnK6wp2ZGBO0YSRd+UNFtF+bk/cKF8Fsev9lLAHn1Bt4gWIH5LDE2Yht8dSj1+lcXgKugRi7C2Um1CW/9y8ptmkHy0nvaeXg1z7KsO28U1MVhpdyfWiQARMdVU/iNy6agE9/U3T+6SHFpLwg+OtC/u5HlEPXkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774556309; c=relaxed/simple;
	bh=3jjkW8De43qk7T35CgGC/qXb8jf9DlWgg/pPdM0aOTk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dvi6tUWS9lH0D+UDHlvFzZArQ5vhrg3bk+0ZPuIAl/sfwJmtWcaUIxWLGu+FH3QMnEED2JFZcG+N720x77jbF69RGehyZhqkk/iyh/CRXcHkqv7uiYXJcdSrvzE14g+Ryie8PS3pWkjk54BOFnsMkS+n1Rj7+oHqng9O7uX5E44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGI5OTpH; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGI5OTpH"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso15590785e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Mar 2026 13:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774556307; x=1775161107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UHCFVniHRT8bAHHyusTcZq8cUIodo6cIGA0i6dLVR0Y=;
        b=NGI5OTpH/Shm3FWUAeCMmJtz8RC52pUNSiKIQJELutvPNOn7cUPNUzBIeu0jzJtcUO
         K+luugch5xqPf+hcfEixDZjw3P10Mxent1zA3AE/YpZ4W7UGgEnWS6Is4/rsJyduR6za
         eD/oA4sa6ekB6F3AhwxIkZYGcxBd4pKnwpt63QgXnFoNkCR0b2mGWyGNC0kBggQqmVHH
         Ep6mkHahrzud1+drnYzi0MsjztlAkaj/YbnYbSuOUYclKSKo0MW+af1EMNSUDir1Bu75
         ft/yOamAUSSW5MYUDnEBSIYKMfRKzegcewxcssXQPYfwIcNZ8zkj9VP0dKl09APQzRA7
         nt5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774556307; x=1775161107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UHCFVniHRT8bAHHyusTcZq8cUIodo6cIGA0i6dLVR0Y=;
        b=mNG3w1DRevRWm1Uzey56cIr75NVx5bki+Jp8JF+7MKmaD8lxJnn2iPZ0eCoPn1WwFX
         tHGq0oNqQw+QIVnVPvxCRG8eUbBOA614iolxk/+AgXd3ZDbF/2yyRL5fNOJkNzIwghFU
         123zcIllaDa6l9ZrwVh8tnEgJ3n/R7czk34FKbdYDccACscgMlXT+B+Lk1YYEEZPSpqE
         hYL6k6URRzGQJL7KVoC1WcdR1S3QJUluqgUYDuMIss2mj5JNUTlir6Q9zQBFQCvdib3n
         98Q+c5XiGbVQrs3sKAmQ82mO4HNPRnWPvv8kFffegdqWVmg+8nsNJYefLRX6EODI43A4
         0x0A==
X-Forwarded-Encrypted: i=1; AJvYcCVGaX8LDoOP3Bx878MAd+J6Cosvn4wnocu0wKyPqMdcUaQXM+EFmYKFcDaHcr+2Cfem3GXxj4ZtzHQj/m4OWOOQ9ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV1jGnCyYBQX5iheET4+HZBflfFs2t2GNnmQ149aCUuGNZ/9Ix
	k4uUy8q2xTDJl++bwt0XAX73aqrCBNt30oAeoXsjiGt1kewCvlaaMVMc
X-Gm-Gg: ATEYQzx6Jom7IcsubkLgLORTEpG6G1IYkvkZ4XzpXbUf/MghBYwkatArsVupMQpRIid
	RX/40CcvDGWkkKKXgoFaN7dy0rfuP9MAGJg8f2jELkkUGF+z3eftl0LeAjnU2R9zADxTFqqcwak
	D/Wqr6MLbTpEfr/Arwpr8oQFgEhY5TR3TuijOrz1tmV2kxlvuG1QSj6vqPJJZLVzQnEELPScSJU
	chNlVUaFMgvtF/+2RgJx833YLfUXDtB9bFye89rPNXLx7G06aQQkpsxc5f7AEjGDx6b/YOYdnWs
	Z/0auKKtdcWXMVjd8Q2yH+o8qCMhE1DI8GSoSadsO6etG289nNCjKzpKtjPl95myyVkxyAr8XUw
	BlFqovfLXT+bRmX2iJ+XJH5pGRqE1UuyHogBMwO2w5tzL//E/Oob8scN3mtRW69w3UI56u/HHxE
	jpggbi9BCYvNVCfzoX/UCaGlSHu+WniZWBfiE7+G/NwfSKcNuMILAo055qUrPJTqeK4qjeVXRAA
	fJnQaN6CeSO
X-Received: by 2002:a05:600c:a44:b0:487:59c:2bad with SMTP id 5b1f17b1804b1-48727efcbffmr298705e9.24.1774556306506;
        Thu, 26 Mar 2026 13:18:26 -0700 (PDT)
Received: from snowdrop.snailnet.com (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48727c0cdf6sm1520985e9.2.2026.03.26.13.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 13:18:26 -0700 (PDT)
From: david.laight.linux@gmail.com
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Aaron Tomlin <atomlin@atomlin.com>
Cc: David Laight <david.laight.linux@gmail.com>,
	Petr Mladek <pmladek@suse.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH next] tracing: Remove spurious default precision from show_event_trigger/filter formats
Date: Thu, 26 Mar 2026 20:18:24 +0000
Message-Id: <20260326201824.3919-1-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

Change 2d8b7f9bf8e6e ("tracing: Have show_event_trigger/filter format a bit more in columns")
added space padding to align the output.
However it used ("%*.s", len, "") which requests the default precision.
It doesn't matter here whether the userspace default (0) or kernel
default (no precision) is used, but the format should be "%*s".

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 kernel/trace/trace_events.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 249d1cba72c0..6b54c10f9ba4 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1718,7 +1718,7 @@ static int t_show_filters(struct seq_file *m, void *v)
 
 	len = get_call_len(call);
 
-	seq_printf(m, "%s:%s%*.s%s\n", call->class->system,
+	seq_printf(m, "%s:%s%*s%s\n", call->class->system,
 		   trace_event_name(call), len, "", filter->filter_string);
 
 	return 0;
@@ -1750,7 +1750,7 @@ static int t_show_triggers(struct seq_file *m, void *v)
 	len = get_call_len(call);
 
 	list_for_each_entry_rcu(data, &file->triggers, list) {
-		seq_printf(m, "%s:%s%*.s", call->class->system,
+		seq_printf(m, "%s:%s%*s", call->class->system,
 			   trace_event_name(call), len, "");
 
 		data->cmd_ops->print(m, data);
-- 
2.39.5

