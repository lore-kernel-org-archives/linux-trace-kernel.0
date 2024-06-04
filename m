Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4279113C8F3;
	Tue,  4 Jun 2024 14:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717511425; cv=none; b=VeMY8G5nUac3Qy6xc54Yje/v/KFSOvhOYi9n/uWHzcH1FiTuBSTK4NWlYpkxIDrBZIrvLaQ1FTu1PBcex7urBVLqiPpzeoq94vq4cwo6Lub0QK0CDPkxUtUa2XBojRj9H0Vjd6z409Y5qVCxIZDTI61WrVyvKs5HV6xpTeBut2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717511425; c=relaxed/simple;
	bh=u8mZLdWoedrnzExV0JCjvhf7ZvbOFMTaDcB0r32i1SI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kHd5lM17PcaJhvb2HQUQ87+L2sV2I6JdfkNhuE+EoKnRPWwnuFWcz6HIgiPgc9GuqsAmkaUVgzR1sqNjyHsBrMwGhNLBN6b7N3kYD03OeNseGVEEKIs+jtaH5uzuyvnGHINGkTOCIpGpIl1eVe3ZrX+IXc5kZmz6b3SzKozXI30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05867C2BBFC;
	Tue,  4 Jun 2024 14:30:22 +0000 (UTC)
Date: Tue, 4 Jun 2024 10:30:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Tom Zanussi <tom.zanussi@linux.intel.com>, LKML
 <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/3] tracing: Fix some selftest issues
Message-ID: <20240604103021.43bae1da@gandalf.local.home>
In-Reply-To: <20240604231829.16b49c8868d310bcdcd78cab@kernel.org>
References: <171671825710.39694.6859036369216249956.stgit@devnote2>
	<20240527192907.49c9220f@rorschach.local.home>
	<20240529014640.3a04f7301f12eb44738f9f2d@kernel.org>
	<20240529083818.b7835de167191d4567405ce6@kernel.org>
	<3a7e679712fb47b6c75af84163b5d3ea252f4da9.camel@linux.intel.com>
	<20240531113721.c0314e0cdb3beb70c1a6ba7d@kernel.org>
	<20240531032425.3635dc93@rorschach.local.home>
	<20240531232047.fca5712a98e360d4a27fd92c@kernel.org>
	<20240604095746.1bbb003c@gandalf.local.home>
	<20240604231829.16b49c8868d310bcdcd78cab@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Jun 2024 23:18:29 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> BTW, some these bootup tests can be ported on KUnit. Do you have a plan to
> use KUnit?

I haven't thought about that. If someone else wants to do it, I will
happily review it ;-)

-- Steve
