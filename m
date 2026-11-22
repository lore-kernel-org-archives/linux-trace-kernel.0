Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795340210;
	b=hOzS3CuZ0nfXC+fgBWpD9cyNUPDPHyZ0+AG3wgDNlUgtsY/uXXlYY1feFIuL56W2Fml8
	 F2Ul1mNSX9Y4v2c9eHVZ8XiJP8PljkDL6jEMjEZy1xF3IEpxq5AtAv1FKRzQ+xNsf1KXK
	 B4bV1PhvzilzznWJ+CjQG6pKqhX6kIeKRhSnIffI263LNyaPXEK5MDfqJm8vmONp2bAzk
	 ANjlMStMLxovVtlXqc36nEBm4LM+j1AEZkpLTwocUAJe3mbITvEsbee87n2fcXdaBF2/+
	 kDPbdSg5xi8WKQqas8Gbm91P3egMVTswk7vGqW+fOMI7vT1prdiyZtUVDT9l2NZ1RlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795340210;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fKC0bj+1Q1nPj8KcJcBKIYkcIVTCOn46jbf4wjPf5W4=;
	b=jTdmCHwhox930/CIx7MzKjsj0k7nMXXVIVWdEPVursTKaAwryIZegPfJWdJxXB8MbYPD
	 I3uVCg9LbGcaeXzCwJGG00lzOphWX2ulU6uKOiqmnyX0SyYvBVNae8VLEE2szwAbUVcZe
	 tddOqaw1CXIjpcYVuJFsr7Mj489cFHyUX0YPfTAuImqZcLkr5cHhvZKLrhClc+oIOrfQ8
	 2eomTsngIX+KOUzv/QB7eHuNJAne4YZW1D27Psthjx7lQNgIi4dLta2C6+S0jOc1/ZZOS
	 I/xeXZ80MN4unqv/BQF/L8PbasI80cnKuQW7FWNSm1GF2zG39zzy/8KtD6Mgu5Uo9Bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Doe4gtlv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26137606A32A;
	Sun, 22 Nov 2026 09:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Doe4gtlv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEDC61F000CA;
	Sun, 22 Nov 2026 09:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795340209;
	bh=fKC0bj+1Q1nPj8KcJcBKIYkcIVTCOn46jbf4wjPf5W4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Doe4gtlvRNq4X9oXZFr6j5wZfDlyWloJCbyfOxmNlvk5FBg4in+iZG8crtzZPsCDJ
	 VBTXfM8vJb2GJLdawu+60PF9MmXNTdMLmaMt1omrbHioYB6i0xgnHyEL+UmRhw4Tw6
	 aMMhk/bdr3eKANfhGGoK24RR3xpEkFDw+EcpEThUVQMbJyyFTlG21Tmi76yXL9ASWn
	 lIUA7/d0BMp1gT0oDFAENqBXvoKXjwAu1SR0d2SheONByRUueUGk8ikM/MEL8+6O/r
	 7o3cY4M0Bgxe06cLCzLWka5o7DILvjY4XjLSMMpJ8XIgHCHbCChJMr3U1N/reJnGIn
	 1GnvK3vyOJsEA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tools/bootconfig: Preserve all-f tracing CPU masks on export
Date: Sun, 22 Nov 2026 18:36:47 +0900
Message-ID: <undine-1795340207193471810-f6280e0e64aa2f7f@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <80d300fad70b4168e2355e8aef73baaef68e49a5.1795307698.git.edumucelli@gmail.com>
References: <cover.1795307698.git.edumucelli@gmail.com> <80d300fad70b4168e2355e8aef73baaef68e49a5.1795307698.git.edumucelli@gmail.com>
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

Hi,

On Sun, 22 Nov 2026 01:34:59 +0100, Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com> wrote:
> ftrace2bconf.sh skips tracing_cpumask values consisting only of f
> digits. For example, on a four-CPU system this drops the mask f. If the
> mask is subsequently narrowed to 3, replaying the export cannot restore
> tracing on all four CPUs because the configuration has no cpumask entry.
>
> Always emit the observed mask as one quoted bootconfig value so a replay

ftrace2bconf.sh intentionally omits default ftrace settings (such as
tracing_on=1, current_tracer=nop, trace_clock=local, max_graph_depth=0, and
default trace_options) because bootconfig is primarily meant for boot-time
tracing where ftrace starts in its default state. So I think the current
implementation is good enough.

For replaying an exported bootconfig onto a live system, bconf2ftrace.sh
provides --init (which calls initialize_ftrace() in
tools/bootconfig/scripts/ftrace.sh). Rather than emitting default values in
ftrace2bconf.sh, shouldn't initialize_ftrace() in
tools/bootconfig/scripts/ftrace.sh be updated to reset tracing_cpumask
back to all CPUs? Without --init, none of the other omitted defaults (e.g.
tracing_on=1, current_tracer=nop, trace_clock=local) are restored on replay
either.


> can restore it.
>
> Fixes: 2b86062a34a8 ("tools/bootconfig: Add a script to generates bootconfig from ftrace")
> Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
> ---
>  tools/bootconfig/scripts/ftrace2bconf.sh | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

> diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
> --- a/tools/bootconfig/scripts/ftrace2bconf.sh
> +++ b/tools/bootconfig/scripts/ftrace2bconf.sh
> @@ -278,9 +278,7 @@ instance_options() { # [instance-name]
>  		emit_kv $PREFIX.alloc_snapshot
>  	fi
>  	val=`cat $INSTANCE/tracing_cpumask`
> +	emit_kv $PREFIX.cpumask = "\"$val\""

Unconditionally emitting `cpumask` here introduces a portability regression
for boot-time tracing: if a user exports a bootconfig on a 4-CPU system
with the default all-CPUs mask ("f"), this will now emit `ftrace.cpumask =
"f"`. When that bootconfig is used to boot a machine with more CPUs (e.g.,
8 or 16 CPUs), tracing will be silently restricted to CPUs 0-3 instead of
tracing all CPUs.

Skipping the default all-CPUs mask was intentional so exported bootconfigs
remain portable across machines with different CPU counts. If the replay
problem occurs with `bconf2ftrace.sh --init`, the right fix is to reset
`tracing_cpumask` in
`tools/bootconfig/scripts/ftrace.sh:initialize_ftrace()` rather than
unconditionally emitting the default mask here.

Thanks,

> -		emit_kv $PREFIX.cpumask = "\"$val\""
> -	fi
>  	val=`cat $INSTANCE/tracing_on`

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

