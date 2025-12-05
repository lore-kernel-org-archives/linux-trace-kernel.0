Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA272DF156
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Dec 2025 17:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764957165; cv=none; b=Wr3axQhtVsJFLNAtk/xe0MCX7mCvclrm+ABOVcRM5dvnawXqXh29kif/DIvMOSs1sPHSEq2+vSUgNAIFxQPXPWOM7GHwkFUrldtgnfsukg4jS8JdFwlHTgfyUzf1y/BUlpBlNe4hUfxWl0VWUqQ2gMpGQsyyxRs/MmxAWRqCFYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764957165; c=relaxed/simple;
	bh=WSOyLaVAbG8nPsi8Fh9vJNEZaG1V5dArA0Vg97NjEvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnt92+/AdXdpqgke+6yNND8jcidK/KE34O4BF9iyg589QlluL8RNQlqTEBC9Fggopeds2Vi0nDo+j11nQVy1hO+ldONRonyQ0ElQjuFglwJR+n2s15udk6WBzlExiTJb5MOVcdgkcNqNhFx9fJXdIIH785fiTelO0MzwePM22zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJnkwzYQ; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJnkwzYQ"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6433f99eb15so2204915d50.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Dec 2025 09:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764957161; x=1765561961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wgVl4UPQOdVuiUQDADihFeO6bzjnbrTXUsfv7qld2JA=;
        b=dJnkwzYQfklN6TTaAJuQ16YzRJmHq+jURTpxoQvIIW1FMEKONaWFcFiYjt0swVjt+A
         zr0hYyYIWXpWT3MLcL7kPDXDEmw1dzGUlpDgpdNVyPhJsKLh7ickV28HCqTZR5sn+y/9
         b2NcGaQEK4/5yDhH+SulYSio94HPbfMhHSjKVdMMVu1Cqk5Z5QQsWMQl+T7v0zVU4k24
         wI0jGFaMtRGhFzQw1DFo1Vy1Z5cegY/xUeHb346U+sA4mCpvhjkuRbFqz3hxWCRZXixo
         PA/HxOc77rlsIoXoQxbmwi1IhcZ4OOEarFU+si7/29hdfWCPTzFBpbmgjYdHMtdJ2Eza
         /osA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764957161; x=1765561961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wgVl4UPQOdVuiUQDADihFeO6bzjnbrTXUsfv7qld2JA=;
        b=MPPf8jC41IKJ9+uprLnwcC4Hk3Ui6xHXhtyb/LQpx8J7cg4Cuha5qHFPJrWLTP39bj
         x4QTo8IFbd9Hbbxvfg8Tq4WFvz3EL5+du2ABMrKeKAqZQtya5KItcdVJxBw+j0mEngp7
         7lMghUJAABfOM8D/gLzGLfngTfpaWPxjL0sZrqXxqUZL6/Kd+PigTHVB5GtPWi51yuPg
         wO3Z1Ia0ii7+rdXcjR5Y+Fx0WHpUjEa6gU7I4lVCcWdU913eh1TRPTUh60gx1L6kXIMn
         01HsplGvU0JWrTnUmdw/ugT9ZhSZ9m+6pUzx79sR/mLGyX0RnITEE3awMkQB25mLNbuC
         L19g==
X-Forwarded-Encrypted: i=1; AJvYcCVT/euS+GRozWuWte1ywr3+sCnLb27K7QDQxXGon5gTjINvBGT+BaoLbEu4Z6ztEWloDOk9/ZufznOpiuIeYPqjpJU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfuVaOUtRFKYtRCu5K3hYrWOo42cAzRZBLnYW4y8W7QnTUHxv3
	Vh9ol2uSwozsRXRlKkwZ+OgbkWd1iU7UZOgNbRRk6aYqOmAuFGjlW3rq
X-Gm-Gg: ASbGnctctz5N8HJhV+VjFtAyJ59sVKplo1jVC5eqgyMvuFBK37H4tpdSAZsndQA5ekC
	A96J6rmiFfy5R9GN/jqQJ5jey4wWPXCF0vW5g393mZlXjmS9PZ6jzofBWGaoaBB3J+NrV9eFl4u
	JumNSmgHhrXnK7m3UPXMSXDi9CM8zSAQp5VG5XgIpraS53HpWajYVa8N61J/StEXE0BWDruIDZo
	nikG6pzog5tB3+qnL5GMQ9QcCgqs1AxdXO5jQWJgz+X+KlhhIjVyV+lNgUwNoklqkKoBvD77oA8
	tsd/r+aZYZgDRMRFbwr3TXt+Mz9u8JaXtOWQCe6NWQXLH4BkOiNcR3zgAvynQrdjpeS4yI947gH
	2u0Yzs/yvLtofNw82E9paVMZogoYg7wVULZZNCeeXuAxZ/qheDC/JXRbKUbaNOtX/NVlxXz8+Hr
	S5Ig/ad/dP7OaKWm9G
X-Google-Smtp-Source: AGHT+IEmHQrMAc5KhCOB44tPj+C3L7ufMqCejlU3WOz8uzACjmQ1s89nXnFrR9N4AEaBc1g4PgKHgQ==
X-Received: by 2002:a05:690c:4f12:b0:78c:2803:c819 with SMTP id 00721157ae682-78c2803ceb0mr17790807b3.22.1764957160598;
        Fri, 05 Dec 2025 09:52:40 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:be2a:7e4d:3bf:3fbc])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b779458sm18946927b3.35.2025.12.05.09.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 09:52:40 -0800 (PST)
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
Subject: [PATCH v3 2/4] moduleparam: include required headers explicitly
Date: Fri,  5 Dec 2025 12:52:33 -0500
Message-ID: <20251205175237.242022-3-yury.norov@gmail.com>
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

