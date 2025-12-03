Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3200835BDB4
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Dec 2025 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779017; cv=none; b=KM4ds8aU++0XXTddk1gywqarMrj/eDf7j+fpNJHZnJxaqUcufQVdvPdfE2it2pcR47ewZzmSd+RQgYHcJtrXHBefQhFmCNCk3bzUkQdKPwJhurZddNoyqNn3ZLHBoBTj56RBIubn9Y7zGBgXyZgG8WN+CSdQ0MzFjGz+UfF/O9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779017; c=relaxed/simple;
	bh=dgbvFR+wx/KjNNenMZxNoDBs++lYjE6vJP+Uu1pxyP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4s8GVDSRAZCcY9ZOS9A7Gpy3VK5R0ZmceuKDlKsGOjVrCXP81Nw6+1N79DJQikTVFJyDPCmN2d/ffZERYVWm3qzSGnPmabZqO+N/hVdODKgjVQXktNpuDvWBs7joEnTKMtBasbyzZOYeX/pr56TNHSzG5HNwMmPuCiiNnF3oSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AxtqqDcc; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AxtqqDcc"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-640c857ce02so6431036d50.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Dec 2025 08:23:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764779013; x=1765383813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XTRUgw7WGLaikLRGDiMOA9ZeBlhI6lBDtpiU6az4ZI4=;
        b=AxtqqDccChC3gI+725Z7hgLZ/dTfwtKfWInrVu+NdzWjrA2AcPXsdC9YqSQUYj81vS
         iaHyegwPG6hpYXfG2ZCh6KvlFRH1HGFGT7sHlWySLEaH6m3DxsY3/n7fyIsdYIbKkQ22
         lGNs3uUiWcMLKOrzTwiurOwnHavrNtoUnEKAhyn61NFPZOkrw+DGbrLX2UzfavKJU83I
         PIjOIAFqL62x8zJhYmpPNVkYhvAjsKese1nWLRkNtE54IKBVcx5w3UER/0XD3rB8A+Dr
         XEwZt33/5hTe3CKGzDXwffrJKnNNU0hK+tYy6TxrpxMj77DCH/G9IP9EEG37Du8gzQQ3
         tzQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764779013; x=1765383813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XTRUgw7WGLaikLRGDiMOA9ZeBlhI6lBDtpiU6az4ZI4=;
        b=dH4dGlHqn5GPiGsjWReraye43Jx04PBeqyu6POhqP+kiHw6+gtjyE143UnHcOjdJpG
         CiPR9PPu1gwk3lr0P5+xFc3hC7hrR6flPo9GKOWaFjvfBARCGoPFKGh6wtcZKthv6XgE
         dNdJRV836pAnxL2EmxMfFaVpt9ivFtgeeFjsZga1NJKKuHYCEBwGINqVywl7+qTYYSi6
         qT0sBQUiCc3P2lzXNuwk5gX2VsO6YA1k/CdVjxdIw13NXATHeHUkUh9L4ThvQOP6iD4X
         uar1KOszGaZbmkAf5vOyDhhT+beanokRfqLUClZGTZSlefDWE+EHqGMmqD4fwEEP+WYp
         lD0g==
X-Forwarded-Encrypted: i=1; AJvYcCW/NDiIITbWTzelbw91He1Wtt1ST2mPpP4Ikb8x/0ZX2Faevz1KsYK6iGrBp60xaH/A4I3g3zmBfvnbyM3BIOxlxFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyBlDnwvHubNUe8s0vqqb7UHUENjQlaFjxdpZcP/16rlge9Ja+
	GyaZI1wd9XFWXbWPXYmsu9rENZ6SAnfMK2CkJTzM6TeGjuqEuyXCGu3c
X-Gm-Gg: ASbGnctEMUVCyAKhcjVZ4HXybGi4WtJd2PgWfC0iE3CuJUPsykon0xQWGIIeokWL+OU
	wqKwwPXbRkoUXQg8ieij/iKM72Q/O0CtYtC2Ii978YOMKStsYPIc1I8li8UC7FSV+Yh8IjzbcsY
	erGfhsqhHdSY+UlRyClVIkJfdSdHw1dMe5wicnqrqYMPFhfS+YhPmtGAN3xdVpiMXeP4xTWHb+p
	dDlkzWqH0IKKsp2zC0fhe3meORZAzKkPROu21yyoaUZqpp9saz5bv1v596hgc0L3Mh4rSCJWh1L
	ameKS4Zbv8Eb+e925ZyARADV34CTY6KOPMO6mb+P89x6+XdS/fvJF1p60EytxcW9oB1u9dYpjY9
	wEEUy6MbxIoGcXkwYeCeLVkN6IghUDXkdIr6x5p26WWavAWCRdi++FxfMSgYAZEuGINm8YdSbQc
	JfShLgh8M=
X-Google-Smtp-Source: AGHT+IGET334KxCtmx0dp1CAMPdeakUWlqKi8VbPsg55HeK6Rek4Uh9+JNYOdEve9S4FB5Tx8L5MGw==
X-Received: by 2002:a05:690e:1442:b0:63e:3994:4ae3 with SMTP id 956f58d0204a3-6443703f028mr1928863d50.41.1764779012882;
        Wed, 03 Dec 2025 08:23:32 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:3422:8bf9:97bc:b085])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad0c25ae5sm76024637b3.0.2025.12.03.08.23.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 08:23:32 -0800 (PST)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
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
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org,
	intel-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
Subject: [PATCH v2 2/4] moduleparam: include required headers explicitly
Date: Wed,  3 Dec 2025 11:23:23 -0500
Message-ID: <20251203162329.280182-3-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251203162329.280182-1-yury.norov@gmail.com>
References: <20251203162329.280182-1-yury.norov@gmail.com>
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
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 include/linux/moduleparam.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index 6907aedc4f74..ca7c8107c7c8 100644
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

