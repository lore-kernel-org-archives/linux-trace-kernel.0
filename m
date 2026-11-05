Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881444;
	b=S1lq/VvMa3GwF9Xb2Ha/CjKG9AMYHKiG1I7cCwT6Zgf8FFuSRRGs8PyBCk7u9GDj1+FI
	 dyEr+CrgWW74v5Z1L8ITgCft+aJuzctp6yYe2DdWUynmylyrqBFYWGFGc6qHO9QGxav4V
	 QS1ubIX543mSsWc2iNXCh0CeJExdAsdNSUpHptXlh/+zb0goRVf5W6K2wGLRgNZrCrsCF
	 iQ+mZwxhaY4bOHDlLVe1gPuRiwMZCP0FE5JrQylMsJ8S2a9V5AZAm4yXhBG4xluYN/AY+
	 WsvVFGd9eZHuPTC0UM7lq2ZVr1ATYXljWgl+bd4RULK0NnImzEcaugx2hKIIbT4HKIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881444;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PCdZhC5qzJrXktlCNM2YcOd+leiW8TzaSSADDfaOdc8=;
	b=JfAMqpY6y9646D5mqYGiycz6Y9awg8r6W+Xp14L7ORO35Ny/+ffy/JTZSplFhNnI7vdG
	 TOCJdB6MDnm5hGK+Dfs6Vi02xCbzpuTZu9f4g6mexUyat4ytAPQLwL3E0WHOsn1ld7bC0
	 wSbhW5st4hD4VWfITh+42X2HNKAuMb5CL9SfGN+pyoj+xDPFc8XbmslgjDz9a+Zq9Cj+c
	 /6L/9prVuFPzfZRTKgUTqX0omtrvtB4rYCEY3KncUy2wUODeoZzIrtzbcXNOs8n0UylAO
	 KMDD0pZSNBDE7vtjK0Gmw/xBr8+zhLQgTHjySfNlZFMnVOuCdfWxloR9c9hacTDvYlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkXLlCT6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C7FE606A326;
	Thu,  5 Nov 2026 12:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bkXLlCT6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B54C41F00919;
	Thu,  5 Nov 2026 12:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881443;
	bh=PCdZhC5qzJrXktlCNM2YcOd+leiW8TzaSSADDfaOdc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bkXLlCT6gyILq9HGx+nhfK6pkf69LHr6gK6zJkj5TPME5e4YAXw5aGQuoPU1bxNeG
	 OLRPGh+f3ra5Lck3kC+2Pe/yLwH44Dv/ou5B+4FOjedsK9zY8KSiSSJIJJLWUQLv/Q
	 zdfpXabJBcm+/lsi9gaA3iZ8Nozg3XRloFOtq2EKn3W/t4SJTf67mgBmLxRZetfISi
	 oQEzOZ1E9EMzHtoXNG+LqRFTFq9YhMSOJj18t/nMJH7/ChGUnsfQdfCfAjXaXanjqN
	 ttJoqzH69/u+oO+VEUN36rizgztYbFEtRELPRzhoXi4zUDs+pYXqdWDxWiuR1U82v5
	 54gwaW4Mk5hEQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Zhiqi Zhang <zhiqizhangg@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bootconfig: Allow keys with the maximum supported depth
Date: Thu, 05 Nov 2026 21:24:00 +0900
Message-ID: <undine-1793881440548019861-0b43d67e7cadb202@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <20261104073742.21202-2-zhiqizhangg@gmail.com>
References: <20261104073742.21202-1-zhiqizhangg@gmail.com> <20261104073742.21202-2-zhiqizhangg@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Wed,  4 Nov 2026 15:37:41 +0800, Zhiqi Zhang <zhiqizhangg@gmail.com> wrote:
> xbc_verify_tree() accepts keys with XBC_DEPTH_MAX (16) components,
> but xbc_node_compose_key_after() returns -ERANGE immediately after
> storing the sixteenth component. It rejects the key before discovering
> that there are no more ancestors to collect.
>
> For example, a.b.c.d.e.f.g.h.i.j.k.l.m.n.o.p = value can be attached
> to an initrd successfully. However, bootconfig -l stops listing and
> prints "Failed to compose key -34". In the kernel, the same error
> propagates through copy_xbc_key_value_list() during its length probe,
> so proc_boot_config_init() returns before creating /proc/bootconfig.
>
> Check the array capacity before storing the next component. This lets
> exactly XBC_DEPTH_MAX components be composed while retaining the check
> before any out-of-bounds store.

Ah, good catch! Let me pick it.

Thank you!

>
> I found this issue while reviewing bootconfig's depth handling and used
> OpenAI Codex to verify the failure and develop the fix. I reviewed the
> change and wrote and ran the regression tests.
>
> Fixes: 76db5a27a827 ("bootconfig: Add Extra Boot Config support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhiqi Zhang <zhiqizhangg@gmail.com>
> ---
>  lib/bootconfig.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index 819685d6c68d..a4aae9a9abca 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -428,9 +428,9 @@ int __init xbc_node_compose_key_after(struct xbc_node *root,
>  		node = xbc_node_get_parent(node);
>  
>  	while (node && node != root) {
> -		keys[depth++] = xbc_node_index(node);
>  		if (depth == XBC_DEPTH_MAX)
>  			return -ERANGE;
> +		keys[depth++] = xbc_node_index(node);
>  		node = xbc_node_get_parent(node);
>  	}
>  	if (!node && root)
>

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

