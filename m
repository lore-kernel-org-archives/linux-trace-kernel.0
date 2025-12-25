Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ABE17BED0
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Dec 2025 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766682580; cv=none; b=U9+jfti6ojwSSQRQWObBM0JjKePDFO3UTnmEc75viX7Ax9gktyfowaGCBFRgVudChUyojtxd6wIY4330+l0Jj8+3ekrxfpEgxjqo9+M2XS0bdIJTmhXzTYG/ceq1rvDu1VKW5sGiEam5VxFD+BItn6NqhvX2Hm7bkP5TM3JQRQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766682580; c=relaxed/simple;
	bh=Y9lHrE5F2aj8aas4pRDKLNMxJ8UQSSadDNHEiSkndcQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HwQrRM/ZazeXmVVTW9W9slkaFv3MPrSN73tX6/EAFiXglOojveCIceoo/YK5iCCqMRu42wT+ZJROJbLpBUutTF8bhI6//xddtvlxV8UhsGiw09beYhughVzST0aaApZJboEQr1qfh4GUA9w3bV6EvFMpeIlQY6aXXtSANMQF/JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=icCFm5ez; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icCFm5ez"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6455a60c12bso6207819d50.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Dec 2025 09:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766682577; x=1767287377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dc5Me+mE1rk9t6TSSnoEi9o5UAq5H187I9GSo5hasb4=;
        b=icCFm5ezjqUJhtLQ3/yCvN9eESfX1JiER7BVXnZeHGpDu/eCBb9e9op0B7+xWUVx43
         FUBMIOab++qyLGS/Ou3WF5dziCEhImhogCzgvEXQQixCbMQTR+OdE1tiWLMeqZtdEt7b
         /dtudqsZxcvZta2IYWQDvx+knx4AJerqDWT0Dn1QclH61zZAQutBsmg/Y0ZZzmel6nQb
         HPllx/XnlBzir/H5OvdiVGRSfPHXIlzgDVBZdyoZ/7awguytpU/OoyC8+IXiop+NiOSR
         90UZgq7vSrOY5GNruxSqTit0CNiiH6tY3gvdPvALCtL2wGJ2DCd6ihwkEmJ33RmEsD+h
         qH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766682577; x=1767287377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Dc5Me+mE1rk9t6TSSnoEi9o5UAq5H187I9GSo5hasb4=;
        b=nEIzi0N/IRyu4ej+G7lhvJCnuq7tefgStDVY/wFQdUNAVzF18mDcGkxqw5aDzHETQj
         V4oMzRMCAqzZXssBkDEEEDc7X/EbQeBgZ0Af0MWZVgyurhB9YMNoIVsmLuT9x/b1oM1g
         DZvDYk4KMIrZIkVGTtckimXQ+mozj2EpB7ZFRAYUD1eLRZh5v1mUOn106BzEfuEUfQBt
         Psbkxw8WVVBWYcFl0N7BZ7VQHAwqN0G5NgDS4WtfpB4p3EK6u2mKSvbS1hJZ/DDwyC9d
         ig606WWDzm7dXSE3ocHFALPyUA5NMqjFbTIg1unO1VLTKwre9sOaLP3eDglw3gLIB/vC
         KZyg==
X-Forwarded-Encrypted: i=1; AJvYcCVbgzf9iRYPXio1BK9RM5wtfnx8IOCZT33pGcGsqnntrEzbWRDJpUxJznFUmXBlBzE7KRxwInkFFTqdESVa0mgimgM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLJfpj9adNdP6fzl/8tgan5ys+qKPIIw6p+Iv11LnFEZ73MxNx
	RVOC5qxuTzlLIGs/lWAIeAkVWEXf0/mHjU3tUTYbZ1o39iGqwV1KSv5J
X-Gm-Gg: AY/fxX6olrEH1074efqDmg2sxt6TkVK+8bT41EjOikJVOjysZooK/Tg9XR/3K27TCFy
	VeAt5rHTgCKWKyqilrfzAxD3ozNT7GoRZbmeWouiBgSKh7u+xtwhajJAeAlx5Yb96LV6jv9Bk3K
	stBnESUnOMiv3JfYUKJD0ZnS5yxNYTKvtV0QyVqn53ApsXAb6YSgA4Ys6FQgZ5lH4PrKcr5tlVR
	hcJtcOtzq/CHn1WBiaga8P2jFmJdfIGKYS2ppHfkAAQx93OhbvqE5WeIO3rYZrJ4hC8KoVVZDHf
	u+CYhyndBBcNMpxwzp9iBFohzkPywQAUkJ8gAXY+6EaD3S7TQglsQvj1ftpEcrevyrx4gbPDHEO
	iMjpi0W7ysq8UwYnckbD3viqp3NviUucrieoAmqstqCBo2H5JeYoH+PzQC5ZhC4hbPN26wbd9NN
	GOB71M4fU=
X-Google-Smtp-Source: AGHT+IF3pn2lAHgaG+6TAPCfe6GjTjYcrsSqlU3VOVIzxXfAGamdgIbuGhSoSIuBjHiFa2I0R1eJBQ==
X-Received: by 2002:a05:690e:1502:b0:644:60d9:866b with SMTP id 956f58d0204a3-6466a9265a2mr13857881d50.92.1766682577038;
        Thu, 25 Dec 2025 09:09:37 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:5a70:118b:3656:4527])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6466a92186bsm9734975d50.12.2025.12.25.09.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 09:09:36 -0800 (PST)
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
Subject: [PATCH v4 4/7] kernel.h: include linux/instruction_pointer.h explicitly
Date: Thu, 25 Dec 2025 12:09:26 -0500
Message-ID: <20251225170930.1151781-5-yury.norov@gmail.com>
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

In preparation for decoupling linux/instruction_pointer.h and
linux/kernel.h, include instruction_pointer.h explicitly where needed.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 arch/s390/include/asm/processor.h | 1 +
 include/linux/ww_mutex.h          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 3affba95845b..cc187afa07b3 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -31,6 +31,7 @@
 #include <linux/cpumask.h>
 #include <linux/linkage.h>
 #include <linux/irqflags.h>
+#include <linux/instruction_pointer.h>
 #include <linux/bitops.h>
 #include <asm/fpu-types.h>
 #include <asm/cpu.h>
diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index 45ff6f7a872b..9b30fa2ec508 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -17,6 +17,7 @@
 #ifndef __LINUX_WW_MUTEX_H
 #define __LINUX_WW_MUTEX_H
 
+#include <linux/instruction_pointer.h>
 #include <linux/mutex.h>
 #include <linux/rtmutex.h>
 
-- 
2.43.0

