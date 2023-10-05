Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A05636B1E
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Oct 2023 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mDAJmhEh"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 802778868;
	Thu,  5 Oct 2023 09:52:35 -0700 (PDT)
Received: from DESKTOP-4OLSCEK. (unknown [76.135.27.212])
	by linux.microsoft.com (Postfix) with ESMTPSA id AE48420B74C0;
	Thu,  5 Oct 2023 09:52:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AE48420B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1696524754;
	bh=nu/UF4tVeZdNh5zANFjJV4boSta2pdlQy3eaAPdXjzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mDAJmhEhR63hv1BYXNbRzNGsWppiNDqBV8kQmdBvkw1/ccD18Xbk7ScyNv8d91iid
	 229ZANuRIOSXI1AaAIMuRcvTqIYK0XP7cf44LnVzAjLI1Qb20tPGTePruxXUjIV+V+
	 v6C/fIWkfDaATNYXovpb0IfLATUQWR4POoOGhR/Y=
Date: Thu, 5 Oct 2023 09:52:30 -0700
From: Beau Belgrave <beaub@linux.microsoft.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>, mhiramat@kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	cleger@rivosinc.com, linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>
Subject: Re: [PATCH 2/2] selftests/user_events: Fix abi_test for BE archs
Message-ID: <20231005165230.GA1247-beaub@linux.microsoft.com>
References: <20230925230829.341-1-beaub@linux.microsoft.com>
 <20230925230829.341-3-beaub@linux.microsoft.com>
 <20231003205908.391d17f5@gandalf.local.home>
 <4cc400c9-f4ad-4a30-a5fe-d02a6a4bcec0@linuxfoundation.org>
 <20231004111437.47c80c81@gandalf.local.home>
 <55213463-8834-4ed6-b0a2-1be69dd838d2@linuxfoundation.org>
 <c6ddb83d-acd8-47d0-8946-5a9b64c65d03@linuxfoundation.org>
 <20231005110816.4b68453d@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231005110816.4b68453d@gandalf.local.home>
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 05, 2023 at 11:08:15AM -0400, Steven Rostedt wrote:
> On Thu, 5 Oct 2023 08:48:14 -0600
> Shuah Khan <skhan@linuxfoundation.org> wrote:
> 
> > Hmm. Which tree is this patch based on? This doesn't apply to
> > linux-kselftest fixes - I thought this was based on top of fixes
> > since I sent in a fix for Linux 6.6-rc4 for user_events
> > 
> > Beau, Please rebase to the correct tree/branch and send v2 for
> > this patch.
> 
> Hmm, so this didn't apply to my tree nor yours.
> 
> Beau, can you verify which tree this goes to?
> 
> -- Steve

It was based on tracing/for-next.

I'll get a v2 out rebased upon linux-kselftest, does that work?

Thanks,
-Beau
