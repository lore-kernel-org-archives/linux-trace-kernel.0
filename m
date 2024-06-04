Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F395818C05;
	Tue,  4 Jun 2024 13:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717509472; cv=none; b=GPePnTr99y++P+BPiE+YDJpUz0ad5Wwm3+PW3CCBPTPZlBxBgMfVjx5TzmU4hwipKwZc5gTnYiP4SoO2CzD5cVXxIZkkbBLneVYOpEftmNPiLa0Yz1rUiDJwGpEqcHGEhfw4q8aeG9n4l80Qwr+kB2Tj3aYoNDczh/CIaUNw9v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717509472; c=relaxed/simple;
	bh=aMBCMEacFCAd34LFVoL5DP9nMf0EsmiIUcjcm9yks/c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MqtA0b6rjI+1QgJQ23T2AY8U2j7raXGALgdvXxKwLbXi3Wd6mc9nLKuNIZvIxknQ+zsZujG7Uv5p4AwVQesyws9ajAE+P4vb3giub2O1whF4jU2VByqgw0r6w+r8kzcC7pTMc8tEMp2PmSexOjvBz7MRhvDnmeRgv1dwiONRr1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C213C2BBFC;
	Tue,  4 Jun 2024 13:57:49 +0000 (UTC)
Date: Tue, 4 Jun 2024 09:57:46 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] tracing: Fix some selftest issues
Message-ID: <20240604095746.1bbb003c@gandalf.local.home>
In-Reply-To: <20240531232047.fca5712a98e360d4a27fd92c@kernel.org>
References: <171671825710.39694.6859036369216249956.stgit@devnote2>
	<20240527192907.49c9220f@rorschach.local.home>
	<20240529014640.3a04f7301f12eb44738f9f2d@kernel.org>
	<20240529083818.b7835de167191d4567405ce6@kernel.org>
	<3a7e679712fb47b6c75af84163b5d3ea252f4da9.camel@linux.intel.com>
	<20240531113721.c0314e0cdb3beb70c1a6ba7d@kernel.org>
	<20240531032425.3635dc93@rorschach.local.home>
	<20240531232047.fca5712a98e360d4a27fd92c@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 31 May 2024 23:20:47 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> The major conflict happens when the boot-time test cleans up the kprobe
> events by
> 
>   dyn_events_release_all(&trace_kprobe_ops);
> 
> And I removed it by [3/3] patch in this series :) because it does not
> needed and not confirmed there is no other kprobe events when the test
> starts. Also the warning message are redundant so I removed it by [2/3].
> 
> So without this [1/3], if we apply [2/3] and [3/3], the problem will be
> mitigated, but I think the root cause is that these modules are built-in.

I'm OK with making them module only, but I don't see any selftests for
sythetic events. I think they should have a boot up test as well. If we
remove them, let's add something to test them at boot up. Then the boot up
code could clean it up.

Or change the test module to be a boot up test that cleans itself up if it
is compiled in as not a module?

-- Steve

