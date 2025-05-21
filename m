Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6335D264A95;
	Wed, 21 May 2025 11:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747828257; cv=none; b=PAXHonbQ0yRuIz3Zb8iTmOq14tfeLbOG0IRqfAvtS8glqhImwdDLh1j9yzBtWghAbRuQ1ntqBQjeVSQ8kHfFRUOkCE+XjmpWWfDcgWqaT3n4AxSS5ugUV9Bz5X8LQZiPwD+EjdlbEm3jPCa4xpPuUJxueR2R1ScbL8tf3MYXs2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747828257; c=relaxed/simple;
	bh=hPxGyl0WCZ5+c5WHm1nrakYwWi2mBp464NPv8RSJ640=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E80nEToJxLCtnG8YXACBauW6HsBYOiFsPbDKqk/5kwiIwm6wPZNA1bhOpHzpXghvr896tcCl82Nj40RdB+AMRxsq4wYduyEJb3aQEla5VRVqgaYgOa8KrW97M//Y6pV/UT9HBKj7cRcRVQ3VqokM4/YKKoQKHd/07cmq1N38qe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LN6OGKx3; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN6OGKx3"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-70dfa1aef36so2293017b3.0;
        Wed, 21 May 2025 04:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747828254; x=1748433054; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wxH6blyBdkBLi+2regCSKNvizDAsAw0qoMZ/7Yx153o=;
        b=LN6OGKx3OxJD3knrRPK3raSSD2hr7OGks+UwDQBd8TYnn5YnycAWzJv4woCFi+JlXQ
         4bpWb5hrH/vP6t58DHz6vuCGJkJdYGkwfm1QcqKf9kKOO1f54t34P2creuzJ/+FNea6z
         XzvrzejptI/BF31o4FQB91xUl3AoWlurtY51r6HjVdFsD3lFjop8M6txUeiuqpkEU19q
         31UAMkT76FzvD1SbdIKdnOCWVFWwfu1zMkkzLJnIVhtmjS8Kupmp4iP3sZjJJ2jlgnVF
         KZgM1gr4prcFXAeFYVBPQmTeXgX0XGr4mO1FpP/huVR0+b+JNWAT/F4JOPHYxoGeKhhb
         1yKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747828254; x=1748433054;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wxH6blyBdkBLi+2regCSKNvizDAsAw0qoMZ/7Yx153o=;
        b=PQiOoQrrjLPSuk3l0dqG4B0rxxXxsxYAQsvIUvqgXhNpAkEYIFTTS+mOaP8RLTK5T7
         47Ocd9A67lrzkZqqMs5fYuawyDDWa/288QUyl9DUKKUWHLaJHYBzokEvsWw2SvRfQdjb
         ys2LF2AloEARsj3VSFMJiEteAfNBh/2Jva/KxHREeizR58rA82par8lNwsAmgPlOB3Bt
         EJj1VYtyh8HSshm9U0/xf5vgXtZdaF7Prs3D6GBYI7ZiE4E7UHjqvkxuXfzceTcih/td
         FMqq9nXrHAhsBdaCXQR3sg4ooa3sV2dytadGQcU9lv3QKgoXZS/DDYqztUeOpCp6NREM
         2VPg==
X-Forwarded-Encrypted: i=1; AJvYcCUf1alQhYVVxGoLSJW4+kB3GqSdGeffPFI3ry/iu1BJlFDF8NnF+BInG2JVQbm6j+rzMVEVs6JhhWNJUKQ=@vger.kernel.org, AJvYcCX0CYgU81neByUynIo2E1U4vE6pfPYRolwbYzNr7lXgS2+I+SpbGJhSUkmMvoR8ePQhvsV+caq3KF4SFI0rkORAvKVw@vger.kernel.org
X-Gm-Message-State: AOJu0YyuHbcSJoJ5pyRb8wf+NldHIMGZ/tzMW3kt2Ri4bQ6on6C/IkWA
	+Gp4vD45DC/qeMRl0HurHnUQpXLAtLpl5o9eSzpHm5yHb7QXI3Cr60kn
X-Gm-Gg: ASbGncsg4DpQpB1Mhme/hOYLdtzBP6CT7oHRSUfX1vxspY6TVh5eqlOvrHVuhm5fbwN
	uiH1z3cHyarV70e+XP13ze2HBAwjzJHuXxDveckU53Oc04iyhpKObFDwlVabrr6aTf/pPwnYIMZ
	jYN/b32huGZe1wJHV1+yv0t1S15mhdnYaHOcil0nIApXsC8LLxqnRcfLBROBA4a1s0OVwmbioIl
	Zx2S7MqajtjtsYjTAiWlWCTPa4ej3DkbKe69twv2MORPSu+VpKNXWn4bB5kbbugpzRl9gBn5GSM
	moJppKan96lFFyZ3g9m4k/Og7jGEwXxVx0jUGSdm8jqGsiYO47GiLuZOt6wRd0Y=
X-Google-Smtp-Source: AGHT+IEZ8zu6Le2G1Gry70fS49+4L4N6IQkrIreprtywefvjnoN17yGjl2y69Sh6wqZ/+UngdIcOcw==
X-Received: by 2002:a05:690c:7341:b0:70d:ed5d:b4de with SMTP id 00721157ae682-70ded5db78emr61451947b3.19.1747828254257;
        Wed, 21 May 2025 04:50:54 -0700 (PDT)
Received: from Gentoo.localdomain ([154.16.192.116])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-70ca83222ddsm26090297b3.42.2025.05.21.04.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 04:50:53 -0700 (PDT)
From: Bhaskar Chowdhury <unixbhaskar@gmail.com>
To: mhiramat@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Subject: [PATCH] tools:bootconfig:scripts: Put back the comments where they should be
Date: Wed, 21 May 2025 17:16:51 +0530
Message-ID: <20250521115018.32392-1-unixbhaskar@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mundane adjustment to the comments, where they should belong.

Does it change the functionality? NO

Does it improve the readability? Probably and that is why.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
---
 tools/bootconfig/scripts/ftrace.sh | 35 ++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/tools/bootconfig/scripts/ftrace.sh b/tools/bootconfig/scripts/ftrace.sh
index 186eed923041..e2a075879db4 100644
--- a/tools/bootconfig/scripts/ftrace.sh
+++ b/tools/bootconfig/scripts/ftrace.sh
@@ -1,23 +1,28 @@
 # SPDX-License-Identifier: GPL-2.0-only

-clear_trace() { # reset trace output
-    echo > trace
+ # reset trace output
+clear_trace() {
+
+	 echo > trace
 }

-disable_tracing() { # stop trace recording
+# stop trace recording
+disable_tracing() {
     echo 0 > tracing_on
 }

-enable_tracing() { # start trace recording
+# start trace recording
+enable_tracing() {
     echo 1 > tracing_on
 }

-reset_tracer() { # reset the current tracer
+# reset the current tracer
+reset_tracer() {
     echo nop > current_tracer
 }

+# remove action triggers first
 reset_trigger_file() {
-    # remove action triggers first
     grep -H ':on[^:]*(' $@ |
     while read line; do
         cmd=`echo $line | cut -f2- -d: | cut -f1 -d"["`
@@ -32,21 +37,25 @@ reset_trigger_file() {
     done
 }

-reset_trigger() { # reset all current setting triggers
+# reset all current setting triggers
+reset_trigger() {
     if [ -d events/synthetic ]; then
         reset_trigger_file events/synthetic/*/trigger
     fi
     reset_trigger_file events/*/*/trigger
 }

-reset_events_filter() { # reset all current setting filters
+# reset all current setting filters
+reset_events_filter() {
     grep -v ^none events/*/*/filter |
     while read line; do
 	echo 0 > `echo $line | cut -f1 -d:`
     done
 }

-reset_ftrace_filter() { # reset all triggers in set_ftrace_filter
+# reset all triggers in set_ftrace_filter
+
+reset_ftrace_filter() {
     if [ ! -f set_ftrace_filter ]; then
       return 0
     fi
@@ -78,17 +87,21 @@ disable_events() {
     echo 0 > events/enable
 }

-clear_synthetic_events() { # reset all current synthetic events
+# reset all current synthetic events
+
+ clear_synthetic_events() {
     grep -v ^# synthetic_events |
     while read line; do
         echo "!$line" >> synthetic_events
     done
 }

-initialize_ftrace() { # Reset ftrace to initial-state
+# Reset ftrace to initial-state
 # As the initial state, ftrace will be set to nop tracer,
 # no events, no triggers, no filters, no function filters,
 # no probes, and tracing on.
+
+initialize_ftrace() {
     disable_tracing
     reset_tracer
     reset_trigger
--
2.49.0

