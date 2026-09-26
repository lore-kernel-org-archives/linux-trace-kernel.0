Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57632348477;
	Sat, 26 Sep 2026 06:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790403257; cv=none; b=dquhOoQO6m8nrrJnwA6mcJCD5aunOqTr/Oa69vhPkSB9MZpEIOnD4Yc9oK3qM3FGswEwk2UA1G2MijAp815kKXwF4ru/Z/6toBqq2/u/hxsKGCgfgWL+XzgAmBcvJoVI5/0TiN2EqLAkMZoCppQ0JUjeEzF8TL/HP49MWB2CeII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790403257; c=relaxed/simple;
	bh=UV6gRnr64yIOTFn3lSM9h1eMiEmacj0yx4FMR+VLWHo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gQUNelbzBzBZ3v2i71NOU5gMpHVCZWMMSuTBiHlDDdfcstJ9Kf13AMAquLHJOuf0RKjFqziiWIhE1ys1qj+Pvl6W/23ffmUK3r0kDWTP797pQ1+DnFfwy2vjEc9NrgpYoE8guRW9s8S+oaQ8drmjYpu6f7LksASqzTJ4erp77Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=R4SsfPN+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="R4SsfPN+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8248D1F000FF;
	Sat, 26 Sep 2026 06:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1790403255;
	bh=NLKST/A5bmY6pU1AodPlaWRwJ8bQxj7G+3mVIWdaYDE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R4SsfPN+BOCGJIw/tZn3wJe12obiZIpQBmdLhQNBcmKZIyyLSPdvsEcTxQpQBzb/N
	 gD5sIxbPDK5gSOwncscqDKnj0sfN07vd5/tswOkbmjlnWgV+IgCFXuO7XWANCfwQQt
	 pcaIbBxb2UQ+EfF8wohK5HjLftIlIiXSUy1o1SrQ=
Date: Fri, 25 Sep 2026 23:14:15 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Meijing Zhao <zhaomeijing100@gmail.com>
Cc: Lorenzo Stoakes <ljs@kernel.org>, Meijing Zhao
 <zhaomeijing@lixiang.com>, Steven Rostedt <rostedt@goodmis.org>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Wandun Chen <chenwandun@lixiang.com>,
 linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] mm: trace: decode architecture-specific VMA
 flags
Message-Id: <20260925231415.3d97401fe7746d82c6182060@linux-foundation.org>
In-Reply-To: <cover.1788330432.git.zhaomeijing@lixiang.com>
References: <cover.1788330432.git.zhaomeijing@lixiang.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Sep 2026 14:45:07 +0800 Meijing Zhao <zhaomeijing100@gmail.com> wrote:

> show_vma_flags(), which is used by VMA tracepoints and %pGv, names
> generic VM_* bits but does not fully decode architecture-specific flag
> positions.  As a result, trace output and VMA dumps can show a generic
> "arch_1" name or a raw hexadecimal value instead of the meaning assigned
> by the target architecture.
> 
> This series adds symbolic names for the arm64 and sparc64 meanings of
> VM_ARCH_1, arm64 MTE flags, user shadow stack flags, and protection-key
> encoding bits under their corresponding configuration guards.

We're presently not showing any review of this series, if someone is up
for it.

Thanks.
