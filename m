Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAC61E51D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 27 Nov 2024 14:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732716614; cv=none; b=tmlueDhg5oV7yz45tLGZP90OEtbrrWzx+9AUIheQgT6EY/GSAJd3JaoWOFhuBtB/85L57y4wQGBMhJTNsCOt4Y/byJy7nfQDZHtfndt0zX/bm/Md/vpgWqKS76gyzEpC9PA+DzeFocREtSY44m3cyUvzPKZZ8ekRHl118QgZaA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732716614; c=relaxed/simple;
	bh=kFR9PUIfM5ND9o1WW+w41Hok+j3QIJY6jvBaATu8WzY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=rI8UdlFeECxH6dwzKPV9ZkBIpFWaLl7pu9M0WeaVxWyNLsSsZtaFfa7FVrLxbU+ieBh+wGbIGZb8d1W8Q5flfjuwGxClz7A4m7bgcd0nE47jSjFG7/NT/akQ3qxe86RQh5v43WUh2WQYWj6DlBCRPG0PajDVivdhrR+TQBp3gs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=obfBiBlc; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="obfBiBlc"
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-5cfd15ff42cso907455a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 27 Nov 2024 06:10:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732716611; x=1733321411; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3jMhxXVf1QUdWvEy2vp558o5guO3soGdUIj9ntlxOTI=;
        b=obfBiBlcaPrODzdJqxRzRNZUGivowy1jFQM/HquQr9ROS98NN9ZAnEbizq7HuVnaiO
         iklIk726bsWEzv/DSKHN9gylbPz/saWcEkFPRy+J/YGGw7Nmq15QBMamYSFJLbL/ucUM
         +n5RBwwzLJcJdhKIk30BC8Ul7HanQQcnNpEuTPp0mEXoAE53LAJWfwbaOQWHQTTSP2SR
         HXTrgAMOvA68Lxxs4TWFV6UK3grUhwY9eEWrV5yl/UvYIS9hILIWT61s+zSKqfcDG3sl
         vTMHIvhATQdGtcMSngR+0RXj9VjpzeY2f0yu5dVd9NHr92437SP7lt1QwXyJg2iv8SqF
         T8PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732716611; x=1733321411;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3jMhxXVf1QUdWvEy2vp558o5guO3soGdUIj9ntlxOTI=;
        b=YzkwmucwNueM/SWdgRDj8j9kL6gDvtzNd5Pp4Nzi/M+6TMD5y503LgxDbrTgDEAcKd
         dynAT8ArN/65EnlvJxkXxunlGMYlI4p4Q2lUutfp6AGoKd77wmeClWTf9pRTxz+KC34v
         TPosL/gmNAK2bs8FURCjsmakZvS9kvz0PLKDeT91fXPh+Hw3crQAB64i7/rHQnd+I3x5
         fKI/NuRSyqEE8MKL0dDuWID40GCM5hevQnZRRZlUS4wyReOPiwfZmQ1creX2HXuJihOH
         pmt43NTuOrDbVZwYyjK0RUN0GcnMTS6rsm0DaYRvJxzTDhDg0hbzGTxaoQXK5HM5sSXY
         66GA==
X-Forwarded-Encrypted: i=1; AJvYcCUQPFGsweNAar14kLC9iwtzR1XwwFqBkqzO0MzrSM5qeP502IqzEK2N5HRDXHK47Ea2xJ7uK3s1uqips5MPrQkEVXg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7CTJT6JweMjc1pazp/zhImufkUOgFzwp1n5Hv2PbmT4ItuEzx
	6sVbvATJ7pd1eNImQl5rQlChSypnphY5ekzYasi/NCE7mHrMrVUc+rQnEpyrs/OtS2f3R/Eejw=
	=
X-Google-Smtp-Source: AGHT+IFwlhr766qLc1hn4ldFnhIVaefGNadp5e+TUp8EreJ0cfnmr57nrisQx2lW5b/EFk+oKdUqLhIavA==
X-Received: from edb5.prod.google.com ([2002:a05:6402:2385:b0:5cf:e3b0:4e89])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:5309:b0:5d0:ada:e44b
 with SMTP id 4fb4d7f45d1cf-5d080c6dcc1mr3352422a12.16.1732716611041; Wed, 27
 Nov 2024 06:10:11 -0800 (PST)
Date: Wed, 27 Nov 2024 15:09:35 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241127140958.1828012-1-elver@google.com>
Subject: [PATCH bpf-next v3 1/2] bpf: Remove bpf_probe_write_user() warning message
From: Marco Elver <elver@google.com>
To: elver@google.com, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Nikola Grcevski <nikola.grcevski@grafana.com>, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
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

The ominous "helper that may corrupt user memory!" has offered no real
benefit, and has been found to lead to confusion where the system
administrator is loading programs with valid use cases.

As such, remove the warning message.

Link: https://lore.kernel.org/lkml/20240404190146.1898103-1-elver@google.com/ [1]
Link: https://lore.kernel.org/r/lkml/CAAn3qOUMD81-vxLLfep0H6rRd74ho2VaekdL4HjKq+Y1t9KdXQ@mail.gmail.com/ [2]
Link: https://lore.kernel.org/all/CAEf4Bzb4D_=zuJrg3PawMOW3KqF8JvJm9SwF81_XHR2+u5hkUg@mail.gmail.com/
Signed-off-by: Marco Elver <elver@google.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
v3:
* Collect Ack from Jiri.

v2:
* Just delete the message entirely (suggested by Andrii Nakryiko)
---
 kernel/trace/bpf_trace.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 630b763e5240..0ab56af2e298 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -362,9 +362,6 @@ static const struct bpf_func_proto *bpf_get_probe_write_proto(void)
 	if (!capable(CAP_SYS_ADMIN))
 		return NULL;
 
-	pr_warn_ratelimited("%s[%d] is installing a program with bpf_probe_write_user helper that may corrupt user memory!",
-			    current->comm, task_pid_nr(current));
-
 	return &bpf_probe_write_user_proto;
 }
 
-- 
2.47.0.338.g60cca15819-goog

