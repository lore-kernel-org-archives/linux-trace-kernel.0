Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795501282;
	b=ma2CogikHyqofc1WpByAQ87UutPGiPyb3e3EFH3+QWjneen+pAnbj53bdZ9Rux1+blDD
	 VXCvTsCYfXwG/Kem/PoYtSl6uHxksF3EFDGNRIjJd3WYhKml1gzgSkKLE0V59gidGqZ+r
	 WQSQPmoFqDF28wUggI1PBns4HXS1UG0N4PO43/Ws7MjnOL6ayJfRlyXsYOmi098epoDsH
	 No+wT14RcoOvfVjxxDmvgg+GKqlbVdVn1vogrzGNt1SwvgW9zK6EFpZIOtBqtcwg06WSW
	 xDDPO3XxqwqpScOZVfZASPasSvFMqfiNJMcyvApiIOn4CL3CbcdRnp2LPunsgukYIVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795501282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=ABoE89s/WFkMcjQ3bulfL2OvrXI3uR+DaKdUMWt3+Do=;
	b=LtXob4emhAQog2TiSxbxduW1yEyi2movGg+PVTksYodFpD4z4T6Oun0BWM+kFYY4BPEP
	 1N5KNkEaldN4tC0F80aZQzEX7PV0HeDcvPxA75ajUwES+COOQuZcC4H11PprQFqdlxXaz
	 kViDW4dwcV/AOyUbZ3QpZHHhrPJxOhucO637XdZnrSWmaGDqxEKULXJMqpjlF1bYBwxmH
	 IOi4eTmJgeB7jQWNOwGPgFKWKVpeAa6sWzqE2bIMlH47mOp8brjObYwVFlEIuOFgrh/Zr
	 IE2u3XRfExdm14yvYyjWwQWsvNTV1XNAmFwAGsYJN/ZvVQ9XifzQFNs7bmKooPZIukQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V0gKFROj;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D82606A31E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 06:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06D82606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=V0gKFROj
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2f0634667aaso13053405ad.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Nov 2026 22:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795501281; x=1796106081; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ABoE89s/WFkMcjQ3bulfL2OvrXI3uR+DaKdUMWt3+Do=;
        b=V0gKFROj2Bzf4HhEsltf1mgTZkhGBlbfiUtJQ7Qwszx5jk+BDR6xEe6Mxx85AgxRLu
         cfljBUaPpgAehgbMImm3c4AerftNLXGITO784IcCNvkvVwOEkCMyH8XbAV8Ho1WX+sBc
         eXkb7nl8gPC7q+CsCtlDBQz0Gk7v6l/HGBZc5m8uVIekFtPf1PdGXFlEdXAPQIaP1hHV
         +zQdKrcvzWEfaMVPDqnBRo/a7VOGirFpIbMx+d63TFlzJhJkezC8jiht6aYgbEyLBpiR
         DohSf6IX1o9dRCcc4/3DPcqENbEfF9m7IeyA4TIsGUDdl9mf22xJHeqfMfQWFgacLtwM
         QKAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795501281; x=1796106081;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ABoE89s/WFkMcjQ3bulfL2OvrXI3uR+DaKdUMWt3+Do=;
        b=QZl6+aA+BrxWNOwIM5Uhq8VY9cGcJ2Ui0TGtPt2dNXt3xUkBiLunWX0qgsXcucjDS9
         3eM+GaVDavt4RSx1iKBaE0kNTwtCNx9wxEhPRGby4J+ywR0y5BzxHZx3JOpFbGSzqL5I
         a0YtirDLAhg9Y2see046Xl9Cj5mbYWpAkyie2tQE65Wmrm2PCfA+2H1iOBerTsAHiCcq
         XTLmYrJfqnDjR3ZKHGmc06P+fwsFo/MBCoK0JuTfHE+oiTu+Wo272mdEO8nTjLWX3Sxn
         Lk0Vd9S9rQsTyDYF02hoPnDFkUW6TBrQY4OkBDx3NWjzg2toNnNRj8Q66r1SG2d9/1CY
         rUJg==
X-Forwarded-Encrypted: i=1; AL+hErH3LI6aJlRzuLYIW6t0t1ENf1aMNuClVGRM5Tvc/ulnlnNBh1gXk0a1DXwd4UW7Mji/cHKHDSQNn68mAfYlXHXFuJQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z96LKhwBIazdoGtvDnu3jb67t1J3ViCvtApeyT4rnH06PqBNs+H
	pKBvu7K0e0GYxqPiZ5044omZI3705NeHVwW0ZEVnUQ6cuGZN9PzQywxf
X-Gm-Gg: AZFdTZfFOKRdEsl7v76NHU+8BBfunu7GOFVflWreDJWtvsxo0BEQUutJJ3h8ficJoPz
	xQ2dFiPBLQt78szX5byj8/akmUnOw3fTyngupprNxUcHFtWpwdSewGA0Ou7kHT807jrKjF3fAxU
	I7d+TywRVgTdv5a5imGVbJf1FDJ2Inrlu45Qsqo4ZvIdGMq+8uPluHf2zo0quAUOmIdHRM/8fSC
	roDCVrrQDE4vbdGhITmXJkxXy1WsUN4SZ+XaBXr2T5nh/dePtdxh1+33rtawdC1r5Bfp2SX1HU2
	beaJ0ECdioxw9Oj6BQkGufagKvTbcyffqiwTmOKK1n4y8HKF3d7jbLZ2TG94aIviuSf4IeekNgH
	hCSh5SF77+ryT41byFwNXVUBIFUR68LxGEijYBxyl98Qff+fjR71uTOrkPb38MudmH2SJMvzswf
	psbhyHNKEqt/OBgE4FtyOsGJ9SM8gijEI/y4kAq4QoUCI5vn7c3mPjFs40uBqxokavmA9my1XR+
	NyGDb54L2yXobEjbSAHP60Nmeum86zZoB2MyFr2Qj7OBIiG5ZXWhrWV31ZAOdccelRHYsYeZFsd
	JlEx2eS4K6t4nqIi6mN3WIjXlWqUb5Im7mQnD64PE6OcUPoZdTEld80E/ja7kJ6UxjGLV14I9RX
	ReU3EXRSbinabB0PuHd3BHUzUzkx8a6e8ww==
X-Received: by 2002:a17:902:f54c:b0:2e3:643:279b with SMTP id d9443c01a7336-2f03f1ed636mr98397505ad.31.1795501281131;
        Mon, 23 Nov 2026 22:21:21 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f118c7dsm64174325ad.55.2026.11.23.22.21.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2026 22:21:20 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 06:21:20 +0000
Message-Id: <DN38312WXPDJ.2KLUTCWSDFL3P@gmail.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "JP Kobryn" <jp.kobryn@linux.dev>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 0/4] bpf: Check recursion per task for
 preemptible programs
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <mikeba@sentinelone.com>, <bpf@vger.kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>
In-Reply-To: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Tue, Nov 17, 2026 at 03:29 AM Mike Bazov via B4 Relay <devnull+mikeba.sentinelone.com@kernel.org> wrote:
> - Marked programs are not fixed. A program with a per-CPU map or a
>   tail call loses runs to preemption as it does today.

I suspect users will hate the behavior introdcued by patch 2+3,
since adding a per-cpu map will suddenly make the prog to miss events.
But the idea has legs.

Earlier I proposed to insert bpf_preempt_disable() by the verifier.
No need for that. bpf_prog_exit_run_ctx() can do it when per-cpu access
is detected. Like below:

> One question: the marking is automatic. A flag that the program's
> author sets would avoid the second trade-off, but existing programs
> would keep losing runs until they are rebuilt. Which do you prefer?

No new uapi.

>   series #2    42.34 [42.12-42.78]  39.87 [39.46-41.38]  41.53 [40.79-41.75]

Good enough. let's keep the walk. No need for the array.

+static __always_inline bool bpf_prog_enter_run_ctx(struct bpf_prog *prog,
+						   struct bpf_run_ctx *run_ctx)
+{
+	struct bpf_run_ctx *ctx, *old_ctx = NULL;
+
+#ifdef CONFIG_BPF_SYSCALL
+	old_ctx = READ_ONCE(current->bpf_ctx);
 #endif
+	run_ctx->saved_run_ctx = old_ctx;
+	run_ctx->prog = prog;
+	if (prog->percpu_state) {
+		if (!prog->sleepable)
+			preempt_disable_notrace();
+		/* sleepable prog should be using explicit bpf_preempt_disable() */
+	}
+	for (ctx = old_ctx; ctx; ctx = ctx->saved_run_ctx) {
+		if (ctx->prog == prog)
+			return false;
+	}
+#ifdef CONFIG_BPF_SYSCALL
+	/* Initialize the frame before interrupts and NMIs on this CPU see it. */
+	barrier();
+	WRITE_ONCE(current->bpf_ctx, run_ctx);
+#endif
+	return true;
+}
+
+/* After an enter that returned false the frame is not linked, and the reset changes nothing */
+static __always_inline void bpf_prog_exit_run_ctx(struct bpf_prog *prog,
+						  struct bpf_run_ctx *run_ctx)
+{
+	bpf_reset_run_ctx(run_ctx->saved_run_ctx);
+	if (!prog->percpu_state)
+		return;
+	if (!prog->sleepable)
+		preempt_enable_notrace();
 }

I think this should minimize the breakage and fix the issue.

pw-bot: cr
