Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDF6345730
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Dec 2025 17:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764957166; cv=none; b=gQw2aYDleE3B3r+4Un3uPt2S5V8qJ3mhaC1SXTB8Ozpya/LN0va9GGt6yQW2rfBQhZb/vYEAzlJkjDqSrmn6KeAE7SenzFbMU9uxr73R22NwEeM+Ip/jfkBBf4rWdqPMScbA3Dxp4J4K90JgnFeOEiqi83jImwSn1n6Xs6R4kNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764957166; c=relaxed/simple;
	bh=6og34fQEZBW+taDejCAi+47vabOoRDY50X8etN5NVU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Muj64jz4OdCX5ow7IIzh8eJ8J40fuk1DQz5Orrgkt2yGWl7WdUs3rsmKyXEqrzKFjMgB1CXA6xCCUU3TT1hWwWpGxjzdDcl72DcJa9A1b9iyXkszKJ+aDjJRoCtwr3zOg7/V9jdSb+l5+9U/zYpHHqmQwInHRXIayHdMBrfDJ8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eK7KtmiN; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eK7KtmiN"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-786d1658793so22032657b3.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Dec 2025 09:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764957162; x=1765561962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qMcm6nWRLFBVfXJXBUXf6pE+rQOQZFvzs8Y8xJm6ysU=;
        b=eK7KtmiNIUz+wA4gwYUjx6iD3q9CGZyEdHp/VrKUxOvvX4jDjS6rUrZaTG0u2vMZPf
         jd+EM1KPrp+vIM+S+7xbgb4ZcVoY/syDiPKoqjJ4wLgSgkTXFSQqNfrMgKzndJKiHvp0
         yw+li5ikEj8CMO/l+T0KKrndsm8lS9GikQS+18np0UAyw/rSg41WvL3h7VmfMVwexd7h
         1SThsPXsesND6a7LZERi2Pro9BID7ha9Rt67YhZl7DRPyfGqJbPFLbYbh4iizQc06soC
         sZpAF76JUZYkt6HtGEwOFr+4Gi23uMW4Zc8I5g8WBiSI4JtBsBDd4iRVaLJwaaVO6U8z
         dUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764957162; x=1765561962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qMcm6nWRLFBVfXJXBUXf6pE+rQOQZFvzs8Y8xJm6ysU=;
        b=VP8DhfHc5IZ9qZ1SSOxfyiXrcATWfcHzB49oBBLlfgkGGNyUaEY5XhAFb6NbRiUQc3
         oKcUYEHYiAzAnDsA1jhAN2nJZx/VujRO1xATFMjHV4fSCBA666Eukz+xCdAWQ2GQgNJo
         vCgd9qtl4BauRM5yYDv36SEyJWewjoxaVHfZ86ZZcjMU6dn2Mc2bl+c4Tn2JB02Ew9C3
         HA03+4hOeBO85YN50TR/Qy1M2ZzlhImuD5WXkkFXvADTWGe8LnhdqkscS37jLWbaaD/o
         ObcsbbAZq4Ec2ozaWv2MSXOHCpxz9rZXLWNG6gxDzYZFO1qJ5z0vc6ovLAuHgd+BOOAC
         aSFg==
X-Forwarded-Encrypted: i=1; AJvYcCWleb9F0cjCAjrL+ZLr+kogPApFlOAD9IOti29AIg9QeYYNQiSayohk4HX+iknOFGxOKus/SFGXYvWKK0MYN4UiIv8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySZqmzJx/1BD7GpEj0d1vAK8oq3DicSMXfIfjAS27lzRep90YM
	2jxu+XmJSZQXh4oIZ6doJYPf8YIpTD5F3FMN9TbWb6+jYGiNfRynKYQ3
X-Gm-Gg: ASbGncsQXatpavrrlK/BRe8WwoGBotjJwNrsvFik/Z2/z3pTQ+TdUgzIPOz1fX4d7wZ
	MIwyHPVaUztIsqPkb95sBiuxKG8ltzojGfBxRxddfhh5FwiQsjV9JkX/0CIPdplwuD0JzXLskTv
	JmeSTLsGxcxkoAXe7Hl1iUrKTmekveOxaGjNrwtAEzpM3u1R1Kgp3q8TpRFcDMLncjuF1/1AxyO
	KuC3Fe6b60AfnDHC7T0NVdp8YDIzT0h0UR2trBEYc5PIN/R3d5gA823zB+OfWrdmJ2YZvRM8B9q
	iLIRhoFcgM3SFDeRKLBjuzFPCuwvt0rsgZVN1nWdfrlJNSwzR8IlFRRAvu6vPrGkCM4fWxXWHAD
	ytgcJ9kd1CnCYcyhVfOPmijiBe7oOntPI+HKbLRi/Gqi/UXWy//Tz4qrLr3yD/xQrO4A1ZFUNsH
	K5uMccEA==
X-Google-Smtp-Source: AGHT+IFMa7PLE5Wadu9vbkWwOz5YfxbRiG9Bng/2nx/P0WjNdaVzVzG0hYz8xn0T4porbVJXTUfmtg==
X-Received: by 2002:a05:690c:2506:b0:784:9076:a0f5 with SMTP id 00721157ae682-78c188bffcamr128846517b3.44.1764957161553;
        Fri, 05 Dec 2025 09:52:41 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:be2a:7e4d:3bf:3fbc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b78e63bsm18841887b3.42.2025.12.05.09.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:52:41 -0800 (PST)
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
Subject: [PATCH v3 3/4] kernel.h: move VERIFY_OCTAL_PERMISSIONS() to sysfs.h
Date: Fri,  5 Dec 2025 12:52:34 -0500
Message-ID: <20251205175237.242022-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251205175237.242022-1-yury.norov@gmail.com>
References: <20251205175237.242022-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The macro is related to sysfs, but is defined in kernel.h. Move it to
the proper header, and unload the generic kernel.h.

Now that the macro is removed from kernel.h, linux/moduleparam.h is
decoupled, and kernel.h inclusion can be removed.

Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 Documentation/filesystems/sysfs.rst |  2 +-
 include/linux/kernel.h              | 12 ------------
 include/linux/moduleparam.h         |  2 +-
 include/linux/sysfs.h               | 13 +++++++++++++
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/Documentation/filesystems/sysfs.rst b/Documentation/filesystems/sysfs.rst
index 2703c04af7d0..ffcef4d6bc8d 100644
--- a/Documentation/filesystems/sysfs.rst
+++ b/Documentation/filesystems/sysfs.rst
@@ -120,7 +120,7 @@ is equivalent to doing::
 	    .store = store_foo,
     };
 
-Note as stated in include/linux/kernel.h "OTHER_WRITABLE?  Generally
+Note as stated in include/linux/sysfs.h "OTHER_WRITABLE?  Generally
 considered a bad idea." so trying to set a sysfs file writable for
 everyone will fail reverting to RO mode for "Others".
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 61d63c57bc2d..5b879bfea948 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -389,16 +389,4 @@ static inline void ftrace_dump(enum ftrace_dump_mode oops_dump_mode) { }
 # define REBUILD_DUE_TO_DYNAMIC_FTRACE
 #endif
 
-/* Permissions on a sysfs file: you didn't miss the 0 prefix did you? */
-#define VERIFY_OCTAL_PERMISSIONS(perms)						\
-	(BUILD_BUG_ON_ZERO((perms) < 0) +					\
-	 BUILD_BUG_ON_ZERO((perms) > 0777) +					\
-	 /* USER_READABLE >= GROUP_READABLE >= OTHER_READABLE */		\
-	 BUILD_BUG_ON_ZERO((((perms) >> 6) & 4) < (((perms) >> 3) & 4)) +	\
-	 BUILD_BUG_ON_ZERO((((perms) >> 3) & 4) < ((perms) & 4)) +		\
-	 /* USER_WRITABLE >= GROUP_WRITABLE */					\
-	 BUILD_BUG_ON_ZERO((((perms) >> 6) & 2) < (((perms) >> 3) & 2)) +	\
-	 /* OTHER_WRITABLE?  Generally considered a bad idea. */		\
-	 BUILD_BUG_ON_ZERO((perms) & 2) +					\
-	 (perms))
 #endif
diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
index ca7c8107c7c8..dd2d990b2611 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -8,7 +8,7 @@
 #include <linux/compiler.h>
 #include <linux/init.h>
 #include <linux/stringify.h>
-#include <linux/kernel.h>
+#include <linux/sysfs.h>
 #include <linux/types.h>
 
 /*
diff --git a/include/linux/sysfs.h b/include/linux/sysfs.h
index 9a25a2911652..15ee3ef33991 100644
--- a/include/linux/sysfs.h
+++ b/include/linux/sysfs.h
@@ -798,4 +798,17 @@ static inline void sysfs_put(struct kernfs_node *kn)
 	kernfs_put(kn);
 }
 
+/* Permissions on a sysfs file: you didn't miss the 0 prefix did you? */
+#define VERIFY_OCTAL_PERMISSIONS(perms)						\
+	(BUILD_BUG_ON_ZERO((perms) < 0) +					\
+	 BUILD_BUG_ON_ZERO((perms) > 0777) +					\
+	 /* USER_READABLE >= GROUP_READABLE >= OTHER_READABLE */		\
+	 BUILD_BUG_ON_ZERO((((perms) >> 6) & 4) < (((perms) >> 3) & 4)) +	\
+	 BUILD_BUG_ON_ZERO((((perms) >> 3) & 4) < ((perms) & 4)) +		\
+	 /* USER_WRITABLE >= GROUP_WRITABLE */					\
+	 BUILD_BUG_ON_ZERO((((perms) >> 6) & 2) < (((perms) >> 3) & 2)) +	\
+	 /* OTHER_WRITABLE?  Generally considered a bad idea. */		\
+	 BUILD_BUG_ON_ZERO((perms) & 2) +					\
+	 (perms))
+
 #endif /* _SYSFS_H_ */
-- 
2.43.0

