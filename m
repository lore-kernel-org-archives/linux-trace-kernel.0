Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F07230F536
	for <linux-trace-kernel@vger.kernel.org>; Sat, 29 Nov 2025 19:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764445989; cv=none; b=QfmqI9eNXbLiD8tlNAnEwowssUz315feShdfk1usAm46h0fibnKgAwXYAbDvJ7aNvBiOgEEKDTcexawcVvo9XN8gZ7l8jVm1+Xk06xDTWYpXn8Wf0yedI5IyfUhEJorGqRsMRKvQH3ir8gV3s8lZ3ShT7C4czISxfkOlvMF/tJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764445989; c=relaxed/simple;
	bh=U6wVjDQqWIkEPY9m3/jjaLkHW2qb9EnJS9XX+Cslv54=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WMhJOUN6JLgTNhgf6AvxWtmLkjAgPaLYbpbPltUAHYeYxcok7zCZabj7ABZgQBq47f4hC32gve5iE5wnoKnOvxgh8SvxErbsWHwa7BMdefnZ9jtT3LmgnJ6grhq0yZUkpB5H7RVfGCmtlVz8axPQO5GDzYeoURFjdG9ohbXrfuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hoxjn+d5; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hoxjn+d5"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-640f88b8613so2045688d50.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 29 Nov 2025 11:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764445986; x=1765050786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMtAFmfUFSqT7Mio9YvaV3lvjHpX+ONaRINwsv8b7ko=;
        b=Hoxjn+d5lQ+osEJtdy81Bdv7RMu4hA2RK5i5Y+W3oyzginhMEjFS6/pCG7jd3KNj6i
         NgPB2Y2agsqDx6g0jkRMSm3jdxWYLUM0UIsOmOGoHCZLoF6aKQ3PnRsKdLokW50Nfy3n
         gk51VQKg7Ybo/izPTilrxXieWKJGb5pixFcz+1SwqrkynepDpkqqqj68UJuK1nYonZvr
         PHqtXNUr1mkPYvPQQHgG+FdfYkuR4zSfnKhk33uBTXSJb6YIqJvU9Fg5R9dhJSRzDYuc
         HNILPUUBmI9Fhg/AjvwUlsFs+O2SHuQ9IHQ9vxPPHqNe4zFlwX96+Kco8FWP8QImFxkM
         M0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764445986; x=1765050786;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gMtAFmfUFSqT7Mio9YvaV3lvjHpX+ONaRINwsv8b7ko=;
        b=UeEAwqQeCa0cbiNblYgrOMdUxB1pMkB2YWGB/pPcZyid9pXQOaFvjucsFJk3I0YjIO
         DqxrfS27xpNb8S63YF2HMADBixtd2rvD2jkteq0xqBb9bsHZbonhqVGgvEBiSBjD1Av3
         RlZ6sTVRTCKrnULmR6nK15gIU0utU8v27WqXyzpOJfG067QcLsNDSAkfPOokYaN0h0f0
         u4dzK/95jQ6DLsqV0ekBqPw6QD9CO8dxMtsI9QXHQg2Zf6S2G9D8nLjPOWhQkLvUx+kh
         YsZ+iIk1KCPQno4Yj4/NkaD1ccv4C4sciRkastzict2xCm5GYGaNCeJ8CO0ooY5p/dZI
         SBqA==
X-Forwarded-Encrypted: i=1; AJvYcCVTfagloEax/MjZ2TXc/MhFaY4U2Cv1tw2DalTipw1myXkiToZSveSkmho28BqB8u8PHPy+fyNkIbI5HMhhMXG+xbU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeUGwJcJCqc+6hv9VWITmbYX/6OzL695STmhh67xFcpN4RfR5V
	OOJa4KKHv0RUX6A6O4mxdsP79n3mYCWp5Vak7XxaFD3/F66/wxVyo8Vm
X-Gm-Gg: ASbGncvAuVvShxdqjQRTrUwcwmfx05HoatBlIrremsCfYVld3KuXiAXUq9o9IGspNba
	xK3FL7rGTQGeNwJm1wrKeA4fq6z9eFBNGPmiNvshS6NokqjIJQdzylDbdHl7y0KeIujLUbIf0Ur
	F5m4UwFVyheafaRBv0r2JuBoWcWhGOnb/MWajxFD/x9+tV0stBk1wQIiWNVKs7bKLqAEgfO44y0
	J8Ywk8PrhN08n2mhN/pauB9eqPUxrX4/05tAGzsOJrvL6SzTmRaxe+EI3+0QvSCU4GQUbkDJfBW
	rNzziMaQHAEf+s4CZvs56kpIEY7aGk4k/M/o6RWSbodosKqZcL0eKpxM1DyIMCoK1z/NvqmsVYx
	If9HJmDaN3Xphf7UhWX8Edu+XkcDN9N9V/c/nNvYjBxbdPkVinccUk6ssPcI/IThj5mu5v9EgOi
	KsZcS4OSE=
X-Google-Smtp-Source: AGHT+IFe8Y0GMh+6LMlCZSdBuNKhw5C68QDt9RitlP5LR9LIFpydTgLo1EIGXwaP+uPjQ4SltW6e2g==
X-Received: by 2002:a53:c052:0:20b0:63f:b922:ed79 with SMTP id 956f58d0204a3-64302a3a8d1mr19964013d50.14.1764445986251;
        Sat, 29 Nov 2025 11:53:06 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:353a:b6ab:d4ee:67b9])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6433c073e07sm2844621d50.6.2025.11.29.11.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 11:53:05 -0800 (PST)
From: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	Petr Pavlu <petr.pavlu@suse.com>,
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
Subject: [PATCH 1/3] kernel.h: drop STACK_MAGIC macro
Date: Sat, 29 Nov 2025 14:53:00 -0500
Message-ID: <20251129195304.204082-2-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251129195304.204082-1-yury.norov@gmail.com>
References: <20251129195304.204082-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macro is only used by i915. Move it to a local header and drop from
the kernel.h.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 drivers/gpu/drm/i915/i915_utils.h | 2 ++
 include/linux/kernel.h            | 2 --
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_utils.h b/drivers/gpu/drm/i915/i915_utils.h
index a0c892e4c40d..6c197e968305 100644
--- a/drivers/gpu/drm/i915/i915_utils.h
+++ b/drivers/gpu/drm/i915/i915_utils.h
@@ -32,6 +32,8 @@
 #include <linux/workqueue.h>
 #include <linux/sched/clock.h>
 
+#define STACK_MAGIC	0xdeadbeef
+
 #ifdef CONFIG_X86
 #include <asm/hypervisor.h>
 #endif
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 5b46924fdff5..61d63c57bc2d 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -40,8 +40,6 @@
 
 #include <uapi/linux/kernel.h>
 
-#define STACK_MAGIC	0xdeadbeef
-
 struct completion;
 struct user;
 
-- 
2.43.0

