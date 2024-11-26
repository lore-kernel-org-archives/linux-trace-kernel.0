Received: from mail-ej1-f73.google.com (mail-ej1-f73.google.com [209.85.218.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1F31D89EF
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Nov 2024 16:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732640069; cv=none; b=VCbbR9Hm1bfECBzXEP2mnS0R3HXytWw0M4LEAy/k7mMhm2I6+uRRcfcnd+8rBC0f6qOS/efAyYb1v8GxSCLJ0vUnv1t7Oeloz84VUVZRuDQghV4Nig6ib/RGTUJckSn6vllmyC2ZDGV8DZ7ob5jGQu5jdn1fkIv39w/F2LLFVhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732640069; c=relaxed/simple;
	bh=DIp+sKw/YUR5DOvPGmLkXi+5hSkr25LLRbjXxJw9Sww=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=kdjdm6PK0FWHAmciBTnLhms2BrMuAk62r+uDwbE55PdO1UZMESsxedXRzJPOrNi5UPUwDMzHO8g4QNfo3orEpPQ1RJwPaIlCylyu+LuaEhbZVTXHVhmwhKwePeifTq14GpmaxirFm0sro4Fh27gTH9fh0MkBm32+ueT60twGw+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dzLhhl+f; arc=none smtp.client-ip=209.85.218.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dzLhhl+f"
Received: by mail-ej1-f73.google.com with SMTP id a640c23a62f3a-aa516e52376so280539666b.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 Nov 2024 08:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732640066; x=1733244866; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FVWAMpSCzHg3fGvJUBSfxRuCq7EFAuyV0JzFHGbmGlM=;
        b=dzLhhl+fcO+4h2td232vfisI8ogmKMBrkGUcsB3l/+wydHxr23LGzaeKxsv9SGyGSI
         T7oZjMBUPMDnsCxJjLi6nZECBIcQlL3pkJLYjHduZlNmJRg40qp6cv9OGDlFwYh+0ccU
         Q+Cyq1CaczL3FRLgnohbwX7rwqvxOtZ5SeMOx/Bpz9hn3/itQnfTKYJGhyObQ0H2xD3G
         NCZ4WSSB5N251y38GDYWEUTe8JZBRd+JaDX4wyvk0LCCdysYip/Pr6LTd1grv/c0ShXU
         KcLbplBEqVbxTTrOPgOzYrTuhTplRX+xThj0TkyYDNCXf9QqGJ3rtVjfGg5lwIBMrTcK
         +12w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732640066; x=1733244866;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FVWAMpSCzHg3fGvJUBSfxRuCq7EFAuyV0JzFHGbmGlM=;
        b=Fl0o4E+UCrthXLJtkkSk/01oA88K/MRN/W6CZ7MT1p9BWBJD/KhIq/lWiPOmNtI/Bu
         dOsjZYeMcxx51U6CTrmZepSUC/DMkkm4eR0bCZScQO4XwNuIXa87qShWol9lBoWHAlGu
         FpetVGtJc5y6PjGdPrhxF6RTRu4E2Iz3T04uD0vcnlY5XG6arZTI0WFtJDfNeFXzlS26
         tfvIclApcCKLBnz012qceWhVTKMfS8qvNkDir1b2an/OZnGyd8W+SB8Q8I7ixiO7zwjr
         aA51SAAqHxCRvUG5GbZHj7X5ilLE7xO++k/sdkaf6R0w4Y89LvgW5F4qG0grARC3ssgD
         7XVw==
X-Forwarded-Encrypted: i=1; AJvYcCVroEtzsCJl1LDV60pCEfJ8G6/ql+msHH5u9SkRnSd/Vbelwh/z2ijVW/H0r0yIZd0p8sxJbnvTBrUUGakm8T3/fnA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKox3iXs4XTa/YiNsXuoiBhxqActIdb9wnyCtKx0iFrtjblEc5
	fHPFIIQNEq9KRxeSdUTMyLG3GDeLMfm7EjS6XJEkugQKcocb43XugHpI9rK9hKDQnc3YMo5jhw=
	=
X-Google-Smtp-Source: AGHT+IGnQ1RVPZpYNr4V2vsGwSrr1TfgOgeHTUES9Lyk5V8C/M8niDnuj/9jgzaUoqUes4SWLxjdrGEpAg==
X-Received: from ejkk23.prod.google.com ([2002:a17:906:32d7:b0:aa5:1a39:9444])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a17:906:30c9:b0:a9a:1739:91e9
 with SMTP id a640c23a62f3a-aa521fdce0emr1032268766b.24.1732640065788; Tue, 26
 Nov 2024 08:54:25 -0800 (PST)
Date: Tue, 26 Nov 2024 17:52:33 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241126165414.1378338-1-elver@google.com>
Subject: [PATCH bpf-next] bpf: Improve bpf_probe_write_user() warning message
From: Marco Elver <elver@google.com>
To: elver@google.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nikola Grcevski <nikola.grcevski@grafana.com>
Content-Type: text/plain; charset="UTF-8"

The warning message for bpf_probe_write_user() was introduced in
96ae52279594 ("bpf: Add bpf_probe_write_user BPF helper to be called in
tracers"), with the following in the commit message:

    Given this feature is meant for experiments, and it has a risk of
    crashing the system, and running programs, we print a warning on
    when a proglet that attempts to use this helper is installed,
    along with the pid and process name.

After 8 years since 96ae52279594, bpf_probe_write_user() has found
successful applications beyond experiments [1, 2], with no other good
alternatives. Despite its intended purpose for "experiments", that
doesn't stop Hyrum's law, and there are likely many more users depending
on this helper: "[..] it does not matter what you promise [..] all
observable behaviors of your system will be depended on by somebody."

As such, the warning message can be improved:

1. The ominous "helper that may corrupt user memory!" offers no real
   benefit, and has been found to lead to confusion where the system
   administrator is loading programs with valid use cases.  Remove it.
   No information is lost, and administrators who know their system
   should not load eBPF programs that use bpf_probe_write_user() know
   what they are looking for.

2. If multiple programs with bpf_probe_write_user() are loaded by the
   same task/PID consecutively, only print the message once. If another
   task loads a program with the helper, the message is printed once
   more, and so on. This also makes the need for rate limiting
   redundant.

3. Every printk line needs to be concluded with "\n" to be flushed. With
   the old version the warning message only appeared after any following
   printk. Fix this.

Link: https://lore.kernel.org/lkml/20240404190146.1898103-1-elver@google.com/ [1]
Link: https://lore.kernel.org/r/lkml/CAAn3qOUMD81-vxLLfep0H6rRd74ho2VaekdL4HjKq+Y1t9KdXQ@mail.gmail.com/ [2]
Signed-off-by: Marco Elver <elver@google.com>
---
 kernel/trace/bpf_trace.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 630b763e5240..0ead3d66f8db 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -359,11 +359,16 @@ static const struct bpf_func_proto bpf_probe_write_user_proto = {
 
 static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
 {
+	static pid_t last_warn_pid = -1;
+
 	if (!capable(CAP_SYS_ADMIN))
 		return NULL;
 
-	pr_warn_ratelimited("%s[%d] is installing a program with bpf_probe_write_user helper that may corrupt user memory!",
-			    current->comm, task_pid_nr(current));
+	if (READ_ONCE(last_warn_pid) != task_pid_nr(current)) {
+		pr_warn("%s[%d] is installing a program with bpf_probe_write_user\n",
+			current->comm, task_pid_nr(current));
+		WRITE_ONCE(last_warn_pid, task_pid_nr(current));
+	}
 
 	return &bpf_probe_write_user_proto;
 }
-- 
2.47.0.338.g60cca15819-goog

