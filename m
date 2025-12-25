Received: from mail-yx1-f67.google.com (mail-yx1-f67.google.com [74.125.224.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3018C236453
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Dec 2025 17:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766682577; cv=none; b=OTtwdNHy9al5dxR9XgIuPHMBQBAm5LkDL3Xiw1lEWOklobuW+hr3MEjLWCRrnGiAeD5VGpjWEcywl8fWQNiqkpKmV+g8JSXdTH+1UIEixNcead+DUrezuxJKreblYwqi9Hjv5BBOjDUwEhJ7D+G9XmMFd7o2bNvtei4m954+DKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766682577; c=relaxed/simple;
	bh=w1WDwaBscjboIEZwjP8FVxLHs8ZbsMOX2p1cP0lc8Vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D6tmKkDUxPtqMDT/bDJtBN1i6iVxnfBFH0rAJAIzK4gTqTyI7fTAAYpsNiytxDQPstkX6sYAcntoTzddjKbNGVLJ5JoIR8Oe0ARGUsw3rHEM/0Nd5uqgdfks19HiivBc+fv6W9FDesgVkVGGBPGKBPIPJesnuV5y8g686ZxIEYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BbLNGWcD; arc=none smtp.client-ip=74.125.224.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BbLNGWcD"
Received: by mail-yx1-f67.google.com with SMTP id 956f58d0204a3-644795bf5feso5902641d50.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Dec 2025 09:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766682575; x=1767287375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RyNbxONE5FjE3NQ/ds0QsvOq9j9R5HrwQHi/I2IB5ps=;
        b=BbLNGWcDuXOLMIXhQ1/9iubWvEpPPTPlW7qQwhxiiiBQ0vSpdhsKlX1UNv1YC6viLw
         GYmzqiLeGFMoYB+/OPTK5tW+0zI7cUXRmlqO2yPRcRVUWfHoRYaptLMRHrOZsgrAe+87
         fe4jRAvVhgrQtHnr61DMXlropQ27Ol92FgSUsN6nN/HmHZxqxMIJ8syhHudTm32EVM4L
         u38l40Dscikos78qasw5G1+7khplvDNemfkmHsnc5iemYoywfN2BI4D1JiLnJHB3DxNO
         TUV2CGhXjRvDn18JpTxQb2FEKfTI84TZlyH7h41lrUHU2RvaBaC2+ii1fX1heyVopEGA
         8U7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766682575; x=1767287375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RyNbxONE5FjE3NQ/ds0QsvOq9j9R5HrwQHi/I2IB5ps=;
        b=gce3Dhkdi5WPNNAAawODJnVGJqzIxPbfdQj5yu67Np3N5di+vA/q4Y6rBNl4+/LEP2
         +yqawHUdl9YoEjz5BRwpAxcyYd4WICg1GpLq6HHE2r7ubauzGeFY1UJmv9Td/bXy8zph
         7Y5JvuTRS/taj+IHQI7zn7rK9cyznpXRnoZusdCDPzNk2OmquB/Qikgs/2MJUQ/uYh64
         eqPUmSaCJNmhm5DJL4A6CoZU5KwqcPlXmwEdmEYRttK977YnmvQhy95mwqKEPE4/UkEa
         pDAtEfqa/4tfgjb3n7pM3h00JQTqZUxQUPLsXUeCTR3R4ACC5uVa/7TUd1ad00evkXGQ
         HcJA==
X-Forwarded-Encrypted: i=1; AJvYcCUb8bTPp0EeH0xbX8Bfcrri9MVk4TVodpKIz4P8mj+o/6JXOPegp3vbwhB61TnhEK5HPnOelpX/CbO6r7OaOEgJzUM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWFyYV2leXmre60hG9lPo3imJhkrfR9B7AszWcSKwbcCfsHw1K
	cwQ+ebIxNxf24sv2zAaskyTt/TWD2xnnXREHO5KtSR8PkUh5G/kz0Jx9
X-Gm-Gg: AY/fxX4eoqzPxNoTCEHzRzmZnf4HRepU2nuom6pRmtPQD5DP8A2pynmatbbv9b+O13g
	cUGll7yXRebJqV98Pz+ybF7M/El2WPtu7IczbBCGlkKnDUKZPXlQkGC3b8jyL4QloRg1GK3z39v
	ZD2T0wLk282ta3ZG6XIYNSp+ewecRACfe7FgrsQ/uO7HP4LhP49CAra66Sk53CiAcIOlfc0N7G4
	d/VgP8FLmv7Y1Ei7vE6X4K7bZlP7WLypAuLaQyYin3ZA4OJ4leGNVY3okNEHQCAOpUW/q3SfBV2
	P0DPOWoAo517h0YNa9mLAU6/iJUmh8tVHonpvQkFiPbkHGx1FcQI15ybKh/FIFVFIqu0PfK96bL
	7N9+Kc3IGPgkReOzfKYdQvMys45QVsDnPhj4ArYhl0FxtGeKH7pVF2qfvRzxhjen82zAsyR3FF+
	Xl8rjGwzEG+us4zkZmYw==
X-Google-Smtp-Source: AGHT+IFE8h6DvR/wQ+jE4yfmtCWCvhxSn9K0kIAiE1b9fgSbqcan4jtnrPelALLy8Mk/xvjxVHggUw==
X-Received: by 2002:a53:c5ca:0:b0:645:5467:29e7 with SMTP id 956f58d0204a3-6466a8b4e26mr13238687d50.24.1766682575137;
        Thu, 25 Dec 2025 09:09:35 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:5a70:118b:3656:4527])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78fb44f3f64sm75744107b3.27.2025.12.25.09.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 09:09:34 -0800 (PST)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	David Laight <david.laight@runbox.com>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Andi Shyti <andi.shyti@kernel.org>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Daniel Gomez <da.gomez@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH v4 2/7] moduleparam: include required headers explicitly
Date: Thu, 25 Dec 2025 12:09:24 -0500
Message-ID: <20251225170930.1151781-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251225170930.1151781-1-yury.norov@gmail.com>
References: <20251225170930.1151781-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following patch drops moduleparam.h dependency on kernel.h. In
preparation to it, list all the required headers explicitly.

Suggested-by: Petr Pavlu <petr.pavlu@suse.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 include/linux/moduleparam.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 915f32f7d888..03a977168c52 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -2,9 +2,14 @@
 #ifndef _LINUX_MODULE_PARAMS_H
 #define _LINUX_MODULE_PARAMS_H
 /* (C) Copyright 2001, 2002 Rusty Russell IBM Corporation */
+
+#include <linux/array_size.h>
+#include <linux/build_bug.h>
+#include <linux/compiler.h>
 #include <linux/init.h>
 #include <linux/stringify.h>
 #include <linux/kernel.h>
+#include <linux/types.h>
 
 /*
  * The maximum module name length, including the NUL byte.
-- 
2.43.0

