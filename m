Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FE9185E7E;
	Mon, 15 Jul 2024 09:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721034731; cv=none; b=SoXtFOL9/2mTcKo86hd8YSTFZq7aDq8TZP7rRjV0mmV23uTy8LuCd78NBAze4RpWbJ1y/KXqcSNaDTrkr2zpoN4+8bzXErnczMFgb7MP1EKISg0+nbvBcwNzm1WyMXsPs4l8E0CL7tzWhp0crTeS69p62L/+d3d1Aiepv3kKa14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721034731; c=relaxed/simple;
	bh=Mcchug6I+yL+6ME9FwAuRnZicvWblXCrtNJQblFaSv4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=enAsy3hmbUG2Q2l4iSEtUguyZ54bsc9EVezSomsm+9IPx7in6uXiGpfWRPtREZdd6vhYGS4MsvAohXjXM35zZEL6wyNygun/SNM0GSJ1E7j2qhfUddzSL1VX5kPxK6+tp49aprkJUggdZ1AMldpXVGLIla8bcmBmXj/Ye4+YIW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRDo+dXb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRDo+dXb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE82C32782;
	Mon, 15 Jul 2024 09:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721034730;
	bh=Mcchug6I+yL+6ME9FwAuRnZicvWblXCrtNJQblFaSv4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dRDo+dXb5hyyUY8YblJaogFBV8Cn6xo9XrXLSpMS3IWcbozfA9E4G3tuwkWiMRHhM
	 r7JCab1A9ycIhfPWCEs+uGO5yXfc/mmg4BCNwbLX3zJZNId1SvH9vo6gYhYBnnn7zf
	 Cf3YUYoThW7frvJz3zdEWJjd4NkaW578kTXUIZl9ehVRdSFn8TvT2YAR8mNSZFv9tW
	 1usQ26SHZjiTk/UUTw8u8RARbYGIb8Id799WwqwJxZIIv6mlTFPhX1Q4XwfePLPQXP
	 K5ZA+LDcdSMdCbAxs0JQKtQJRtz+pPQBLfnUIcCZGE5cTVekdIzQkIVXJoY6K7p+zF
	 c959ZJc4rrK7g==
Date: Mon, 15 Jul 2024 18:12:06 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: wuqiang.matt <wuqiang.matt@bytedance.com>, Andrew Morton
 <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
 <kernel-janitors@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] lib: test_objpool: add missing MODULE_DESCRIPTION()
 macro
Message-Id: <20240715181206.f0b6c9e6bfc548c2b729b76b@kernel.org>
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
> 
> /jeff
> 

Can you resend it to me and linux-trace-kernel with Matt's
Reviewed-by? Also, can you add the warning message?

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
