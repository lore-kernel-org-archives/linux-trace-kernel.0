Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D723D2417C2
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Dec 2025 18:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766689042; cv=none; b=HoJMyqzApg/fzWuoCq5HBF45ldWMQwACCVqkGdBcUVcXxBwkC+fXYeKCuwHznWWVgyURPqjhQNcg+4YNI8PVCQH2Ha4WcCKYIzTWk9H4p53nIaIu22iQcYy95MmIbD26snOGoFFXGICkLaPVkh8jZbExp/WXh10YVffYWtzQOBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766689042; c=relaxed/simple;
	bh=Sp3BBI7rqWS/x5u5n95rHXBvTYUWZEdDT2uy0cYwMU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ehLkhsyKqcuiSYUbFmR6LpP9aAiJqESF1O4AKwfjZX/rEIOlUCldz03hGiLo37FX7NX9giPWtMkfLs1qsCtQq26L4erwCAvePXCv+48GQroARIpDlhHNfqmCNzNmj7OXuokkCNYKB5msO3Omup5Qn/ZDRGPCtp+xdJaKij2WloI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuCfHOZi; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuCfHOZi"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-88a347c424aso90471846d6.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Dec 2025 10:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766689040; x=1767293840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hauBx7stO8fgVv7cwKU+lRmpmOfl414DpJwGxBenCpM=;
        b=FuCfHOZix7y2ThWq8rWfdcyq4DjCRvkK86/Jd2b8Q995TRuXsugmf4coVGCCp1Zo/D
         WgDLKmk0J3Y3IiXU0H1DcDx/xl42KwTKWEOTn1Ew/+fy2v2llI87ipt+YKl7is58Po1q
         Q5sJlXGzZ6dfCPJnWafGKxq/HfQH4V8+WoiYMvKJsR8GdbfvRS7SBPncsF8fFMYEgzjS
         jkjAKO1nfRtvcggc+S+KW8GYqH0pGn9hQaELF8qCWjXpPmm6AUPhMJE+sjHVt3twUtpQ
         Lxqm5qWM5XAuX6LLNDbU11PsUrd/7vrUgVcpXy/f5c54GtzMX80ji/fFRQTcgHGjm+OM
         IUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766689040; x=1767293840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hauBx7stO8fgVv7cwKU+lRmpmOfl414DpJwGxBenCpM=;
        b=XZwZdhLTuc3LINmCdjWH9gp/hQaTMCIDdMIdyZkCcszKZmuW3qjMPWv03W5oKnVnox
         KrLncApvxz3oYf62sF7e0W3YkuHOUxIMfmNBGIKxbp1Tj7AxAOB/djwnH+Mx/lZe24+j
         JRBu5fFLPPRm+Gl9g1DExnLOmXFeIu4B7ZsvYeVC9MCF5XbqqN9roUdkjbcqsPlfaL8j
         dY3nbpyRGHdzcW9ENum/FaBov42+ncsweSuK7NpN1nSYCE8zaPqnkmkC/Y+st5UQZEGL
         UsSE6/vPEAajgSCVKS1lBQazZ5INMaVaUEwHghLOFW/GBEzDwnjOEWcWUdaJ0QnI4b68
         fRLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvlyKTRpxKvWnjdgcImTONQ4YjsUc/zyGZvOWdfAszwIrave0IMOx7ldUU+4DxL53ZrWORNtRLLX2+17AT+ja2Lmk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkXfs0CCptMpXhuSAnB/iM1ivk4GsC9JZNquzyHXFsNtuxp/fh
	z5cYbyBvjDg5BCgE/CJ/BFz68EIs6ZBj5eobeom17qf6LeweEavMa5ItL0zR+w==
X-Gm-Gg: AY/fxX7hnq7IYTPdIUu6ceMvNBTxug7QUuv2704byP+9xHv2l2hsoYBeypDBhkkAAA8
	6uNToRM+LPPyFsJEfwu7zsR84dOvWFvPgfMEokaYAvE9apsOMI02tVRV3/MB7eUae2V5eHpCu70
	ow80rP5xPny6wcFU94N9SL7uazYE+IdVFFAKK9FDqSF7xalNh5Nzo/u83J4kLKDCWkPXK6tDABO
	/P6ZjmFSPPlieqz72epulXV5Ac87VRtukAK4eKuYzH6YFIVMDd0HxSDJk/cD9rGYwMrAfsNUAPg
	loIOxfOwd/UHBvXGBQMWGuFp+tZQKkHcevJR1yMmZFwhwnNx+shbhTdZxtRcPunpvTdR0PJpc5n
	y29hKWKfrr2YwxRWaHWRLCFH2P9y+xGcTiJHVWN5OLhpu3BDVlPPNNp6s+0/MD8g4wQ+wj8taM4
	S9J/ycpZI=
X-Google-Smtp-Source: AGHT+IFOC5KnXE7Y/86OXEfn0VfROKTdlo6cIy7sSNHG4HuRQ93qgtI5LmuQjuxLc/KbIiLosqGOQg==
X-Received: by 2002:a53:8592:0:b0:63f:ad6d:cbd5 with SMTP id 956f58d0204a3-6466a900e02mr12636421d50.60.1766682577930;
        Thu, 25 Dec 2025 09:09:37 -0800 (PST)
Received: from localhost ([2601:346:0:79bd:5a70:118b:3656:4527])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6466a8bd6ffsm9803141d50.9.2025.12.25.09.09.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Dec 2025 09:09:37 -0800 (PST)
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
Subject: [PATCH v4 5/7] tracing: Remove size parameter in __trace_puts()
Date: Thu, 25 Dec 2025 12:09:27 -0500
Message-ID: <20251225170930.1151781-6-yury.norov@gmail.com>
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

From: Steven Rostedt <rostedt@goodmis.org>

The __trace_puts() function takes a string pointer and the size of the
string itself. All users currently simply pass in the strlen() of the
string it is also passing in. There's no reason to pass in the size.
Instead have the __trace_puts() function do the strlen() within the
function itself.

This fixes a header recursion issue where using strlen() in the macro
calling __trace_puts() requires adding #include <linux/string.h> in order
to use strlen(). Removing the use of strlen() from the header fixes the
recursion issue.

Link: https://lore.kernel.org/all/aUN8Hm377C5A0ILX@yury/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---
 include/linux/kernel.h | 4 ++--
 kernel/trace/trace.c   | 7 +++----
 kernel/trace/trace.h   | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index 5b879bfea948..4ee48fb10dec 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -329,10 +329,10 @@ int __trace_printk(unsigned long ip, const char *fmt, ...);
 	if (__builtin_constant_p(str))					\
 		__trace_bputs(_THIS_IP_, trace_printk_fmt);		\
 	else								\
-		__trace_puts(_THIS_IP_, str, strlen(str));		\
+		__trace_puts(_THIS_IP_, str);				\
 })
 extern int __trace_bputs(unsigned long ip, const char *str);
-extern int __trace_puts(unsigned long ip, const char *str, int size);
+extern int __trace_puts(unsigned long ip, const char *str);
 
 extern void trace_dump_stack(int skip);
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6f2148df14d9..57f24e2cd19c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1178,11 +1178,10 @@ EXPORT_SYMBOL_GPL(__trace_array_puts);
  * __trace_puts - write a constant string into the trace buffer.
  * @ip:	   The address of the caller
  * @str:   The constant string to write
- * @size:  The size of the string.
  */
-int __trace_puts(unsigned long ip, const char *str, int size)
+int __trace_puts(unsigned long ip, const char *str)
 {
-	return __trace_array_puts(printk_trace, ip, str, size);
+	return __trace_array_puts(printk_trace, ip, str, strlen(str));
 }
 EXPORT_SYMBOL_GPL(__trace_puts);
 
@@ -1201,7 +1200,7 @@ int __trace_bputs(unsigned long ip, const char *str)
 	int size = sizeof(struct bputs_entry);
 
 	if (!printk_binsafe(tr))
-		return __trace_puts(ip, str, strlen(str));
+		return __trace_puts(ip, str);
 
 	if (!(tr->trace_flags & TRACE_ITER(PRINTK)))
 		return 0;
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index b6d42fe06115..de4e6713b84e 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -2116,7 +2116,7 @@ extern void tracing_log_err(struct trace_array *tr,
  * about performance). The internal_trace_puts() is for such
  * a purpose.
  */
-#define internal_trace_puts(str) __trace_puts(_THIS_IP_, str, strlen(str))
+#define internal_trace_puts(str) __trace_puts(_THIS_IP_, str)
 
 #undef FTRACE_ENTRY
 #define FTRACE_ENTRY(call, struct_name, id, tstruct, print)	\
-- 
2.43.0

