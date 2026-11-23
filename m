Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795438145;
	b=W9rMdHDxitUlxBcD+v/BDA1RH3IBAnyWNtZFJcvfkb4J6kLCT3kr9V39D8fRsy11mlbX
	 8qV3THBM0Krah3MBrobv9T+6hB5o4TxbhybU58LIqbL0HOyUNP7eL6LohuebITvqJevpW
	 tCqNhOrc5jxbl81LW7bp293ubzOMVhHJ1BeJQggsBFoynsfjO1B4EMrPWefcyKJwnrbqy
	 Px5YQCSiZIh1pPEkfrLSEHCJ+jZ2rYe20VFZkt0vqjDYzxd49Aoda/COWgWw6WQ3FaIGE
	 lXA8TXEii+8PvZ2jNuJkEliBW1eZLiaBFQKYr7os++QXAz4otDpqCASoGCW5FKItXdQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795438145;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=kFSS5Lpx23772o0jxHiqpcMGc1EZfFQoRb+B8VLiMXk=;
	b=UgAb7CO4bQ0BdoX375svcFiIeP+ljldKHGtIvv1rb5uzWS1M37L1UmcMQpneAyVb1U/H
	 5PkA285bps4JPjr1w+YVSd8mtraxJxfQHwt+p43Cv1361Wd5R8vofRt/uV9NtCLJTl5Sa
	 BzKJfAJCqFaf9WMpp3cSm9gPpu5E+qNj8w5jfFg3nz/oHvyZT76COLJsRskLWNepR1jSf
	 GMwAMaUahX9aHNYV8x9s3bklwfqehA3qMbecxEP1oZlLhkaQdoX2836bcsdsfO0kAY9Qn
	 XjqbVbHsYsoJ6ohyO2VUmpHyigXbHBeC+htTXmR+kwVdYX5DLrZaDSh5H6bAqcTAEqw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=IrLGZGTM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1CA606A321
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 12:49:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F1CA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=IrLGZGTM
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3b3f9cbafecso434082a91.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 04:49:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795438145; cv=none;
        d=google.com; s=arc-20260327;
        b=RCzRF4cAX9u25hm6UfI/7i6W0SGleL4GwzLTyilgu8qBG8LSeLXVXoMpe40esrrIkX
         Pa5Qa+GJVkY8dmAUcVrI/WcH1xwvXHCEcN6B0hj9b+0/HQmINYEEx7Ec9wMBlUO5Hxbm
         llaqdDWNNB7/UUgzOYtFLAqdb3XvtUJ5uv9nVb70g3iZ/3c3gwa6MXE5QGPcNMrKIIX5
         hYgT1TUroNLBvsf8GS1jg56TGk5Qy3+ngU+wE0pPLpTq/y2Ti6vFEJ3/xSuf6kgVMtTD
         l6+9RrmVZe8MzsGmMGQqWMvKWrywP0nFQ6l3IyAJGGAUbatahsy7WbuQ0BJAh+LB7C9O
         ZoXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=kFSS5Lpx23772o0jxHiqpcMGc1EZfFQoRb+B8VLiMXk=;
        fh=KZIIs4T6w9qbffIUsaQZKjiFteoP+vmKkBt4HUoiMUg=;
        b=BbKHlAbwNIv2L+7dXKzP8rYHS85uS5vR7uePSaSOVj0I2R6hbk6tY04gnJBeqZZV30
         dd9pxjF7H9/b5jsq5+NCT0rxBs3oLFXrTm98lXNcdqDbBuFBv8t+7lKrpqP2P4HcKPws
         cRz0AAmz6vbo5RAmraJZVaGBebA1keCkJlUic7LVnKBhrwTXHdJDHKHYpG/ft0z593bG
         TSrU45tRey/O6e5vAMcAfUmkoSh4x3D2hHP710UapSsLxOwJ8wqYpGgjYJWVc4VmESTx
         cSQy3KnCej+qSRgei/tUp6mxzq4zKGXDyhrmGGdQtXXYOZ1QSk6zmiOTiNpAwYuqhXHE
         1FxQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1795438145; x=1796042945; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kFSS5Lpx23772o0jxHiqpcMGc1EZfFQoRb+B8VLiMXk=;
        b=IrLGZGTMUyOCRbyjw5X/ob4WE1mDOIB8tymNE6Fl18vATMykCZjkR9ZOpfSbs0dFQr
         DyDTvbD882R78Z+CNFsfT3cgEj2tf7HmIi1cUQp+JXi+dKVp+EPEPWBEVQtbs9rbR6q5
         KwVAi+pO1JsD/bNB+RLjwZ6nZEB9ZPk398zuTPP2sgxg8c63z4onxYkd8M0UXJ7iplab
         j1fLdy0neYv3JyMlkvMYoaM/WHLacvrs5edGEY+ATzeWJGtQ/eUTyWbmpQWUCsWOf37N
         J3S1IRXLnTIo2bKeEQMtL1FrA67bQg2iAO0vj8y8yq6U/ElTdWHYFKQLyaSuBqjZ9rCi
         t3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795438145; x=1796042945;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=kFSS5Lpx23772o0jxHiqpcMGc1EZfFQoRb+B8VLiMXk=;
        b=c5VFckeMGBxqLWTgEVlawZcI6dcYUp6PsTl4qO/yHBkTKt2/0dPNltlUGDQ5N4DLNn
         9uT4PEvcfnPlyVmLk51fh4mJGlTsuhSoNrGlHwu0T2Ql28SbrvzqMmdyu3Gxfp4PsgjJ
         kMEzKqvLPG6Fg9mnc1M13/XJW5jxbgFSKOwT8cNjA9p8qIw04OLV+j63PhdF9vrmhN/a
         KOITsTUpkJF+oYBh/OJ9O7EYDUs5jwndaevF3LJVLT7oj5+zISuZ0FEkQMZx8qko4T4E
         MHu/b7pOYsX/B/oxj+f7heEZFRNkc0+yglErp4dlRuIiFjt+TXErLsFWlsEBHYWsfaYl
         j/rw==
X-Forwarded-Encrypted: i=1; AL+hErFrY4kME4zKjlh57t5co2s6aaafFlb/GQ+pzTMC+e5b3yMmAW0JD8lxj6rcF5Kpx2Xvka6PEmilUy1NsbiRm7jLw5s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+01TMnkadmYL0Ks1VKeUkLzn7dSAm0IpQGGDk+yU6wGrfNdkYY
	z+T9LtezWnhE+/0fpF29UA85BOTVg/Iq67LWWYzEbyX3cQuE4Vn5SNCoWkVkD2cHp/IDxQaBy0d
	bEW/TexvZDkxYbQQoMuzEfZEa9j9TMUcNPKC0N4FvPg==
X-Gm-Gg: AZFdTZcs21PV7qMKHSWwsH6GzPReIN5Cnj4o8Kdi3WYOZrk/N/xmAG7shN8Qp4tEi6A
	Dri7ysyVEbsoBfH7p/GWc/iepZcgDJkvJYrbzzFTdyzOqrSozQ64HBoFXh7u70FfT+M/5ITsJip
	xEh5RlEOW6K7X57d3lXrS/1nlErZOAmLHf1gz1f+M60U5v86pTF+6dA02DN+kNgq9M2hez6BjIQ
	GCSSPIlU3/HP/0Zu/7mM0wShzQynjJIWH3yinLT1WhixsfQdEL/WUKu0wPAKV5YCffkhGLW22zY
	Qc6uOQgOBUk2WIhBOrzBLrQoZbQdqwQTLy1+6nxG8L8ekk27zRuhMaFeT67fq5wzzQqc2EN10jj
	C+XqS5QjIS3q6GWPXgVuJLkA9xaQua6eI6O4=
X-Received: by 2002:a17:90a:c10e:b0:3b3:c92e:f523 with SMTP id
 98e67ed59e1d1-3b41c917320mr17695252a91.3.1795438144716; Mon, 23 Nov 2026
 04:49:04 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
 <20261117-bpf-preempt-v2-r2-v3-3-586376ec3672@sentinelone.com> <8fa7eb35-950f-49c4-b60a-c00b52cc6e4d@linux.dev>
In-Reply-To: <8fa7eb35-950f-49c4-b60a-c00b52cc6e4d@linux.dev>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Mon, 23 Nov 2026 14:49:07 +0200
X-Gm-Features: Aa3M54oTl11TCFGAigV7UhZBuv7UvpVpxQ6riby4wl4QTdBGKnWaIn2NNnXrHOQ
Message-ID: <CAPnbwjqUgxYmiviUVRP0PzPPcYdOHkESrhBepkQuPqA-tdyyMQ@mail.gmail.com>
Subject: Re: [EXT.MSG] Re: [PATCH bpf-next v3 3/4] bpf: Check program
 recursion per task via bpf_ctx
To: "JP Kobryn (CrowdStrike)" <jp.kobryn@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Martin Kelly <martin.kelly@crowdstrike.com>, 
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, tyler.wilson@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"

Done. The array is not faster than walking the chain

bench -w2 -d12, M/s, median of 10 runs [min-max], lazy preemption,
x86-64 VM with 4 vCPUs, bpf-next 32b66b94c86f, in boot order.

The existing benchmarks:

               trig-fentry          trig-rawtp
  bpf-next     39.36 [33.73-39.72]  40.02 [37.00-40.78]
  series       40.10 [39.43-41.41]  39.63 [38.99-40.06]
  array        38.97 [38.19-39.17]  39.19 [38.58-39.90]
  bpf-next #2  39.74 [39.17-40.12]  41.12 [40.14-41.68]
  series #2    40.68 [39.68-41.58]  39.81 [39.33-40.49]
  array #2     39.89 [39.48-40.29]  39.49 [38.85-40.34]

I added two benchmarks to bench, with three programs nested: the
measured program starts inside the third one.

  driver (raw_tp)          calls bpf_ktime_get_boot_ns()
    fentry on that helper  calls bpf_ktime_get_tai_ns()
      fentry on that one   runs the loop that fires the measured program

               trig-fentry-nest3    trig-rawtp-nest3
  bpf-next     39.88 [39.42-40.52]  41.44 [40.93-42.68]
  series       41.25 [39.95-41.95]  39.62 [38.62-40.50]
  array        39.59 [38.15-41.53]  38.22 [36.37-39.02]
  bpf-next #2  40.62 [39.79-41.13]  42.84 [41.96-43.50]
  series #2    41.48 [40.09-41.94]  41.10 [39.70-41.63]
  array #2     41.06 [39.73-41.80]  39.67 [39.07-40.08]

The array is patches 1 and 2 plus this in place of patch 3, with two
fields in task_struct

const struct bpf_prog *bpf_recur_progs[4];
unsigned int bpf_recur_depth;

 static inline bool bpf_prog_get_recursion_context(struct bpf_prog *prog)
 {
+ struct task_struct *tsk = current;
+ unsigned int depth, i;
+ bool ok;
+
+ if (prog->recur_per_cpu)
+ return bpf_prog_get_recursion_percpu(prog); /* the old body */
+
+ depth = READ_ONCE(tsk->bpf_recur_depth);
+ ok = depth < ARRAY_SIZE(tsk->bpf_recur_progs);
+ for (i = 0; ok && i < depth; i++)
+ ok = READ_ONCE(tsk->bpf_recur_progs[i]) != prog;
+ WRITE_ONCE(tsk->bpf_recur_depth, depth + 1);
+ if (ok)
+ WRITE_ONCE(tsk->bpf_recur_progs[depth], prog);
+ return ok;
 }

 static inline void bpf_prog_put_recursion_context(struct bpf_prog *prog)
 {
+ if (prog->recur_per_cpu) {
+ bpf_prog_put_recursion_percpu(prog); /* the old body */
+ return;
+ }
+ WRITE_ONCE(current->bpf_recur_depth,
+   READ_ONCE(current->bpf_recur_depth) - 1);
 }
