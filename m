Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF2C713B5B2;
	Mon, 15 Jul 2024 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721032225; cv=none; b=lL3GExVZTXHGT+Gm3AkVyUVQPsB30gsehMW4w80KQnf+KfF3YO+qjLEK+zunDw3E41uqgUEW7jVGPRhScmqz+U/bhoPYUXiLxG9dGGkcFTCnjELPA09mYjjnXZDjhBq9yrfs0kvg3+wWItGamt8axpykYsqGc6WgLuKDpmWs3V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721032225; c=relaxed/simple;
	bh=cnnjx6vN6SkcRwmo0gZuagUL8/r39lmyNh61FPnqguw=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=LnCp+JlL8GwiwObguRG7xDRzBBUuDfZgqeiGQWU0pBxrIfX2P142nyXkKIOWDIB1hzzcKsoJq9odBHhoSMD9weh4WsJtd8gcNrxv5dn1LKbWPUi/EN6aGjXQ8dY2IK7o2Dqj4z5RBMNLqP/d3cu0piO1nTLC7jWnjhs9zXOJo9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJ+GBtbJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJ+GBtbJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C94FAC32782;
	Mon, 15 Jul 2024 08:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721032223;
	bh=cnnjx6vN6SkcRwmo0gZuagUL8/r39lmyNh61FPnqguw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FJ+GBtbJX952GMve1l54H8b42/5kTc+0uO7eCtQjBidtFsdTBsV0dgxCLPZJq82If
	 uU46t+HAwaiEu04a443yVFwd3ojZP1MXsdHsJqmooYZMhP58TFYvrp7g02KYzNXH2S
	 /XGWTbhXiIAZKJdeinQIIIPDCCKIY4OLYE3hlylEBXRLnc/bDN3GNQgI+wu8RBfrob
	 yL/LahS7ggKYwZJyZpfdX18HBr67Wrke4ogfop62DVDgq3bB3GlfSFnKgoABvdmIFe
	 6rvE0ngwH3+Xqdj4tTHQm9un9fYYcPCW4NVKkLYYxDSzVjEAyF20+ISw1DhMF6ZDvX
	 d7h+Fx71UiwQg==
Date: Mon, 15 Jul 2024 17:30:19 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: wuqiang.matt <wuqiang.matt@bytedance.com>, Andrew Morton
 <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
 <kernel-janitors@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib: test_objpool: add missing MODULE_DESCRIPTION()
 macro
Message-Id: <20240715173019.ebe734f2c8182ca0f13b7c7a@kernel.org>
In-Reply-To: <3edb1529-744c-4b7a-acc9-12e166ada738@quicinc.com>
References: <20240531-md-lib-test_objpool-v1-1-516efee92a05@quicinc.com>
	<7ba64e00-373b-4c13-a30a-113646dad588@bytedance.com>
	<20240603154549.4a338c065e42f07c8c3d1b82@kernel.org>
	<3edb1529-744c-4b7a-acc9-12e166ada738@quicinc.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jul 2024 11:14:20 -0700
Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> On 6/2/24 23:45, Masami Hiramatsu (Google) wrote:
> > On Mon, 3 Jun 2024 11:25:59 +0800
> > "wuqiang.matt" <wuqiang.matt@bytedance.com> wrote:
> > 
> >> On 2024/6/1 08:31, Jeff Johnson wrote:
> >>> make allmodconfig && make W=1 C=1 reports:
> >>> WARNING: modpost: missing MODULE_DESCRIPTION() in lib/test_objpool.o
> >>>
> >>> Add the missing invocation of the MODULE_DESCRIPTION() macro.
> >>>
> >>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> >>> ---
> >>>    lib/test_objpool.c | 3 ++-
> >>>    1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/lib/test_objpool.c b/lib/test_objpool.c
> >>> index bfdb81599832..5a3f6961a70f 100644
> >>> --- a/lib/test_objpool.c
> >>> +++ b/lib/test_objpool.c
> >>> @@ -687,4 +687,5 @@ static void __exit ot_mod_exit(void)
> >>>    module_init(ot_mod_init);
> >>>    module_exit(ot_mod_exit);
> >>>    
> >>> -MODULE_LICENSE("GPL");
> >>> \ No newline at end of file
> >>> +MODULE_DESCRIPTION("Test module for lockless object pool");
> >>> +MODULE_LICENSE("GPL");
> >>>
> >>> ---
> >>> base-commit: b050496579632f86ee1ef7e7501906db579f3457
> >>> change-id: 20240531-md-lib-test_objpool-338d937f8666
> >>>
> >>
> >> Looks good to me. Thanks for the update.
> >>
> >> I added Masami Hiramatsu and linux-trace in the loop.
> >>
> >> Reviewed-by: Matt Wu <wuqiang.matt@bytedance.com>
> > 
> > Thanks, let me pick this to probes/for-next branch.
> Following up since I don't see this in linux-next.
> I'm hoping to have these warnings fixed tree-wide in 6.11.

Oops, sorry, I missed this. Let me try.

Thank you,

> 
> /jeff
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
