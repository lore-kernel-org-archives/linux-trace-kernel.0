Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793453486;
	b=pIU+2WSTxhWCZ5SMYPP8jEpt+/1BCgdl4RIZ75iyja5wGG+3nRhTvJEL2iu9rBF3Q1eB
	 Kaemm8mjbcPzL6AmNjYHXnxe58nHoV/RGaux1aaUFF0aLBCrdDmP4fvzlf5eQmw6pat5V
	 48wGkFt1foAtU+TnKYNxCw60FYUTL/t8tWP0X+lNuVz4jRmtLg9eFHPTLIPZlflRmdhVv
	 T8PRWzgLvXt8ovlDiJoywKO2jXP7KOZ1WxW5Hl0xmpP+zli5Ey4YN1qkVm5n6W5bu+ASh
	 0isS8dwqNk8ULVMPNv5jk7YZvJTsLSU/iQYK921hqFdPeOVld3kEnk+AF2kLSxppCsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793453486;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=PJNVVxE7OIZ4yKjAIaacSz6SsBBJvpnt+JxXa9+t5Sg=;
	b=XpplT1vxkfqoVvuwSRQneJxF0Zv5GhFJ+xfQozeMKnZk7jXV4oKxun9S5rD9YTstAbd7
	 125FSR5SC1lzq/qaYH1JQ3CElwNuju1nNZIAJ8OS/O3KFVGDMgFdeK+q/s8C5yoQ6Y2oa
	 fgxXitUiiAARJx9HcPUBpXMT5FZ/IjiN84HDZGRQ1Jb6FHxc+5lehV5cwA7HWctKm8VDz
	 B3dN3cyX9/RO+Fgk7PzQTUH4P4K547bz6/5rXCgc54OmiytOZkabRwdXqR6svL50HSsU2
	 OUZqxXGwI0jYfAcG8CFTgD4ZU8ZGbAVS8RTJtXIT4t7ocj3oETCuGfhMaApxGtO8Hdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g2TadhsM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA22D606A31C;
	Sat, 31 Oct 2026 13:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g2TadhsM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B4AA1F00919;
	Sat, 31 Oct 2026 13:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793453485;
	bh=PJNVVxE7OIZ4yKjAIaacSz6SsBBJvpnt+JxXa9+t5Sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g2TadhsMJggUoREUlf+t814kuuj29R2baqc4pV8biJAkBr2mE4OJvb8HWSooU3HDs
	 9+DwvD5ql/UUsadMKXTDQWSXXFAh12Q9+j4YFpeNQCQgm4hsQ1gTo63/U48vKgEJ3D
	 yKMY7KvVdJTrppqlDe7k+tb5pFNXkz+utlO9MuT3gNEinMgR42rXusSWiDdEyAOGn6
	 9ZZpvxXfWp5TEh0IIpqA0VhLAmWyQQhYa3L12Dc8YzeZ70YVH/zF09Vr87JpMVsKZ1
	 nbpinYJeqOgt1i+EoHICO3SZkPtFCGP6+LG0jV/mKeXH5bb6kfxWAMG1nL6GudYvuw
	 rQlFsmJF06m/A==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>, rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] tools/bootconfig: Preserve tracing settings during export
Date: Sat, 31 Oct 2026 22:31:23 +0900
Message-ID: <undine-1793453483000634761-30a1647e17bcfa19@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <undine-1793452028139689664-4d0bf20c02a1c855@undined.local>
References: <cover.1793364709.git.edumucelli@gmail.com> <cover.1793442331.git.edumucelli@gmail.com> <undine-1793452028139689664-4d0bf20c02a1c855@undined.local>
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

On Sat, 31 Oct 2026 22:07:08 +0900, Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> On Sat, 31 Oct 2026 11:25:30 +0100, Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com> wrote:
> > Hi Masami,
> > 
> > Thanks for the review. I've updated the event-filter patch to use the
> > explicit delimiter pattern you suggested. It now warns and skips filters
> > that contain delimiters and both quote types, since bootconfig cannot
> > represent them. The other three patches are unchanged.
> > 
> > Changes in v2:
> > - Patch 1: use explicit escapes in *[,\;\#\}]* for the delimiter check.
> >   The semicolon also needs escaping for the shell to parse the pattern.
> > - Patch 1: detect both quote types, warn on stderr and skip the filter.
> > - Patches 2-4: no changes.
> > 
> > The series keeps event filters, generic trigger counts, histogram
> > variable ordering and paused histogram state during export. It is still
> > based on bootconfig/fixes, including the two fixes you picked up earlier.
> > 
> > I retested the filter change in a temporary tracefs instance on my Ubuntu
> > machine, running kernel 7.0.0-38-generic, with recording disabled. I also
> > checked the mixed-quote cases against real tracefs filters and added
> > regression checks for both quote orders and all four delimiters. The
> > fixture checks cover each fix and the full series.
> 
> Thanks, this series looks good to me. Let me pick those.

BTW, I will move these fixes (including your previous series of patches)
to bootcofig/core, instead of bootconfig/fixes, because it fixes a script
which is not related to kernel build/boot process but just helping specific
users - who can easily get the latest kernel.

Thanks,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

