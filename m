Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E28E1EA7DB
	for <linux-trace-kernel@vger.kernel.org>; Sat, 29 Nov 2025 19:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764445990; cv=none; b=YX3s8QOEvqp7p1f09502hUZlqNZ6USz+0A3Tr/+m/FEPIKJuIZmF2R3PZpG6OoZwpqnFaMQ7s42b6YzMFFjY4CTJJHBKsAdDe6O4UQM2wqb/C/zLFXvlT3ylGgVqExHgYAQqJsxvQK43ThtEX5Op89n7GUIGeWQgmRMAhiClLes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764445990; c=relaxed/simple;
	bh=FdiOAxi8x3qeEv/Dh//XevJQnEeuuiAcs/Vi/TNMfo0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1ZIlZViouoeCOsg0L9lDPnvVC7JC6rdnGZY1lPMqe1bglJ7GcIiosUpNiBPPyjVqui7Nwrw+4gU80ySmUvaOgAevKS4mrbaGWYdgEn9ikiQHlDR1f27YrgF0aQkEm/Mk/MrEyrGtOUNXww/JC6ukI7PvBKoqJLFKvkjUNbpC9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsQkxn5C; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsQkxn5C"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-63f96d5038dso2363950d50.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 29 Nov 2025 11:53:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764445987; x=1765050787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1J39AX21q7vFvdSQspB28V0qpAzX2/AVdKjbIUMHgo=;
        b=gsQkxn5CeSWsLIx5Q07eFrabGC3wNQn896BtPFZ1HHdO8o1dXUjUAVs1sPGhnvkr5h
         dbo++8cvEbMH/V4GE5J7VLHjQxleD58kd3QtDuTr1/b8OVZrTlbs38aypYifTQu4rr27
         93wwDQfI1RKh0FFva4xDub6om71OacNVSf+sxZWHPBp/TXk26MvUfqlUZpah18QQ21Ca
         QQV3+DUAnqlySb3upmvYoLaIcQJ+/BV8EYK3hC9x3K1934z8DgxbOr6jBG4Ox5Cz5Aww
         AAryjRhhy7F3t35tgETfzPTw2tuv8TNIkrrzxrHg/4aC/gaXGiNPpKrDrux3+IyGNyLn
         GCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764445987; x=1765050787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T1J39AX21q7vFvdSQspB28V0qpAzX2/AVdKjbIUMHgo=;
        b=LVNkeCQiqhIk5frHO+ZFOY3pS+DzWQhB0OzvFSR5oYitIw7g3xGln1mONj8Ta8sgM+
         e3qT55BK6w+stoAllzDE/21RlW43kHIz16XKuzu0DBEC1GvPmI7rx/xo8A2Q7aXHSKXc
         3BKCJJM2f5Qj/LWEz+PPXf1f/9yVJ0OD9m0EQVXU7DKhwskoT3xIEqueY2PeQ0o2y86B
         M9O+8l3QIP4du34vUtTAYu0IGAuqJuPCRIlNRBaP+S6PXSwlrQecAlqyfoiL3vl76gvc
         RgSnn0wep1V6kaHaDhyEaX1jReEjx6FlwZ8r6B5+B43Er++KhXVQeVOBBG5lhuMWp/Av
         YwUA==
X-Forwarded-Encrypted: i=1; AJvYcCUfsdNnxsjf/kXEsnfmPo3+Nq+nXXrD/u5edjuNJ0TBqGbJAqmQToRkxFUKj9wz/p9mhLYZLbIJEaKyW+gvqzLJt58=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNb3BS+Y2kGO50sXrU2QsHUUrt0DL6NluHEprHudNSYXj24UqQ
	LVn5q2zZP6vBcYWUk6S8Jo+UOK8ZyNbdXsEd1q7Q/Hzk69IdjBmx9fpe
X-Gm-Gg: ASbGnct311NWubs8NzBP8/tMAh/m6cciUFKDvbN2RVDCRoiI7lzHGYW8VvdTz5OGGUJ
	CsoABF5zZToRt0F4XW9T7NF33JxEDB2fyqGUwaX2xrkI5kASiVHf433UKrUbBs3fAPfl54mmOWR
	/1v5f1fCffogBF91UpgjOQNDXNGybbVvU5PDzkl8APuKFQRhtnoMMtqpCVIRkBGfHDxUBJ7zYBC
	g4QwyNN4Q2dwRQPMgwPkvIuxCRL7FAJEue59z+PkpXbow+lz9pRSn6TDjhLy1D0IOobXqOVH2ug
	l66Gkyed+ofYw7xP/JVbPC8q7sdSFAwlTSZgf4XNNyIK49sEmIbEkFLWMBCpSEoaosoMcwmBRca
	j5hPBe/JruT4dIukidoJA8I/MdtN5vBpSNPCJg1movbkdNDU7pKG8afpfNzybT/YDmh4s5giQLi
	v0x/zcwlc=
X-Google-Smtp-Source: AGHT+IGoe6k+HGoU1YAfc/PgjNGtkUsJD9d1pFuoEvQqZEuvaXl0b1nF4MNPaTfl/35pvJr8rQDxmg==
X-Received: by 2002:a53:cd8c:0:b0:63e:1943:ce49 with SMTP id 956f58d0204a3-64302abb486mr16805469d50.39.1764445987167;
        Sat, 29 Nov 2025 11:53:07 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:353a:b6ab:d4ee:67b9])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78ad1044f9esm28752057b3.56.2025.11.29.11.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Nov 2025 11:53:06 -0800 (PST)
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
Subject: [PATCH 2/3] kernel.h: move VERIFY_OCTAL_PERMISSIONS() to sysfs.h
Date: Sat, 29 Nov 2025 14:53:01 -0500
Message-ID: <20251129195304.204082-3-yury.norov@gmail.com>
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

The macro is related to sysfs, but is defined in kernel.h. Move it to
the proper header, and unload the generic kernel.h.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 include/linux/kernel.h      | 12 ------------
 include/linux/moduleparam.h |  2 +-
 include/linux/sysfs.h       | 13 +++++++++++++
 3 files changed, 14 insertions(+), 13 deletions(-)

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
index 6907aedc4f74..4e390a84a8bc 100644
--- a/include/linux/moduleparam.h
+++ b/include/linux/moduleparam.h
@@ -4,7 +4,7 @@
 /* (C) Copyright 2001, 2002 Rusty Russell IBM Corporation */
 #include <linux/init.h>
 #include <linux/stringify.h>
-#include <linux/kernel.h>
+#include <linux/sysfs.h>
 
 /*
  * The maximum module name length, including the NUL byte.
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

