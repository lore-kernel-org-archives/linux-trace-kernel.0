Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE621CF289;
	Tue, 19 Nov 2024 15:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732029963; cv=none; b=arddNM1u5H1vwE21kQvNdZiozfOQuSqr3irnt3tvQ3sKCNGgK7zfLY30+knLqSd3kVfcGxpP6orTZN6IWZRUczN3MubZg+pi9Qq2BgFANtR0HVXxptQbijyRXFq74Wmk3KCasYYsO0bErhJedJtDkBdKic+Gn9cq22t4QOsCny0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732029963; c=relaxed/simple;
	bh=rhuMipy5eUn7kq6F0Kj2GQrTkKVy0Juy1GFirjisNpw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mzu9Kxuuqs19x8Uof4R7PKorm42OzesC8VfVmZh/IrOkyFOTrfHPDf5nXOF/x7x9NMEY61qV8CFY5LfJ2c++203hw6DJm9jCPCtExuTchul77+tHevFehHD+Bhyw6f6f/PBZTHGCJGo62VhpRtSAgDD3vJmofBiYmH7/WdZ5n58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93893C4CECF;
	Tue, 19 Nov 2024 15:26:00 +0000 (UTC)
Date: Tue, 19 Nov 2024 10:26:31 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Geert Uytterhoeven
 <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>, Tomas Glozar
 <tglozar@redhat.com>
Subject: Re: [PATCH RFC 0/2] Add basic tracing support for m68k
Message-ID: <20241119102631.76363f2a@gandalf.local.home>
In-Reply-To: <22856ed6-b9d0-4206-b88d-4226534c8675@yoseli.org>
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
	<3a8f6faa-62c6-4d32-b544-3fb7c00730d7@yoseli.org>
	<20241115102554.29232d34@gandalf.local.home>
	<cbb67ee2-8b37-4a4d-b542-f89ddae90e94@yoseli.org>
	<20241115145502.631c9a2c@gandalf.local.home>
	<2c43288a-517d-4220-ad31-f84dda8c1805@yoseli.org>
	<20241118152057.13042840@gandalf.local.home>
	<22856ed6-b9d0-4206-b88d-4226534c8675@yoseli.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 Nov 2024 15:24:00 +0100
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:

> Indeed printf gave me clues !
> It appears to be a bug in libtracefs (v1.8.1). rtla segfaults when 
> calling tracefs_local_events() in trace_instance_init().
> 
> Debugging libtracefs pointed me to the load_events() function, and the 
> segfault happens after tep_parse_event() is called for 
> "/sys/kernel/debug/tracing/events/vmscan/mm_vmscan_write_folio/format".
> 
> Going through the calls I get to event_read_print_args().
> I changed libtraceevent log level to get the warnings, and it says:
> libtraceevent: Resource temporarily unavailable
>    unknown op '.'
> Segmentation fault

Can you do me a favor and send me privately a tarball of:

 # cp -r /sys/kernel/tracing/events /tmp/events
 # cd /tmp
 # tar -cvjf events.tar.bz2 events

You can't call tar on the /sys/kernel/tracing files as those are pseudo
files with size of zero, and tar will just record empty files :-p

-- Steve
