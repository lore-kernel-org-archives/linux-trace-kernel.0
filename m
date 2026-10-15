Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831EBC8CE;
	Thu, 15 Oct 2026 00:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792023319; cv=none; b=ADg2xIBoZPh1hL8qWSrfbzSedfmUqeESMXnKeVTLInRLmWNQ251vNB9+glYojR1PmuFlLynfg+FYN602LGYgeI7k01sF3Cd8piwOgghDArkE8Ewohg/AzaCvXMFXzG1ogQo9cka5axRpfF9ZhmfPyrBCqtcPZfyF7MiW3UXPxlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792023319; c=relaxed/simple;
	bh=UsDG9kfDxd/2k1VapBH87PTBBUwyRDmBw4Na/K/UQyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-Id; b=FBWOwAFl8IejgO0BKcOAIJ6vUuz5YmT6Of+66tJP/KuE5XynopBVnvyrgvMJkIRMIOR3eHTjksGV3RBkHkcb8dln0GWFGrhGLveV/PGfRox3PS/r6jPrtSOnNCMl4gs/YXuBWIcSfIYyxY/JVIuALIja2SJk6GEWS+GA00quzM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T3pMNRjk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T3pMNRjk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A06451F000C4;
	Thu, 15 Oct 2026 00:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792023318;
	bh=0qxweQ3nR9WEGRFyiRmVZV79kJCBfaEjOPO3LF2GMds=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T3pMNRjk3Khltt1RwSbhY7DnUfXFXEyuMB3yxNH2Rep0WCMfUIm6V7STHpja6RM57
	 XSy2Dq8aBWOC0Dc5U2Khd/g5NkA3ZSXkYJ1TIjkRxdALrcdMscG1AiRWsAI8Sm8odc
	 dxpoqNiBLN8bx6nDIbFsqBvlQA8/KoXrhviQvxwBnK1x5G/b0GXFPP0tmB3zAOHwLx
	 p88Cg7+22YOtCjQNI2yDwOqpNzADgYHXkWOdfOJLgDTwKV9Z2zxlLdu0EPsFmcHsi6
	 8UVRS63lB+nwT8Ge+KKkMpntfZkZWd0h2Cmh+iglij5mEjay5UqSzMeIOykoRSgalw
	 LDqmzjLme5EZA==
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thorsten Leemhuis <linux@leemhuis.info>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Sang-Heon Jeon <ekffu200098@gmail.com>,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Mark Brown <broonie@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
Subject: Re: [PATCH v2 2/4] tools/bootconfig: Consolidate xbc_init() to error
 message wrapper
Date: Thu, 15 Oct 2026 09:15:14 +0900
X-Mailer: UndineD 0.1
In-Reply-To: <20261013212351.ce16d411abeb7e710eed5157@linux-foundation.org>
References: 178913597653.248794.1237187523153227751.stgit@devnote2
 178913599508.248794.10388592925402087434.stgit@devnote2
 1dcf2ee8-02f7-41af-b1f4-bff3a16a2c90@leemhuis.info
 <20261013212351.ce16d411abeb7e710eed5157@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <20261015001516.A06451F000C4@smtp.kernel.org>

On Tue, 13 Oct 2026 21:23:51 -0700, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Wed, 14 Oct 2026 06:04:52 +0200 Thorsten Leemhuis <linux@leemhuis.info> wrote:
>
> > On 9/11/26 16:13, Masami Hiramatsu (Google) wrote:
> > > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > > 
> > > Use init_xbc_with_error() for all bootconfig initialization in the
> > > bootconfig tool instead of showing errors in different way.
> > > 
> > > This simplifies the code logic and make it easy to maintain.
> > > 
> > > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Masami, Andrew, this patch is now twice in -next:
> > 
> > e732d7c18d4d6a ("tools/bootconfig: consolidate xbc_init() to error
> > message wrapper") [merged via: "9eae8e94e61f20 ("Merge branch
> > 'mm-nonmm-stable' of
> > https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm")"; next-20261012]
> > 
> > 78715511921cc8 ("tools/bootconfig: Consolidate xbc_init() to error
> > message wrapper") [merged via: "71ee85976d09e8 ("Merge branch 'for-next'
> > of
> > https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git")";
> > next-20261013]
>
> OK, thanks, I'll drop the mm.git copy.

Thanks Andrew, I'll keep this in bootconfig/for-next branch. 

>
> I was surprised to see bootconfig patches in the linux-trace tree, but
> it seems that's where they're hosted.

Yes, since it was introduced for boot-time tracing originally.

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
