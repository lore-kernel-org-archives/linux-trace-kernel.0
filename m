Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1481EE7DC;
	Wed,  3 Sep 2025 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756913486; cv=none; b=bJcXEpmLwTuyRPcAysly0O9Qw1D/5rQF/rsgRZeQxBhKnZrnLMh0HvgoC+cJ7PaeiCT/kKbhD17VEmpBj/1uocgMSq4zSRUiis2xraVTt0TD2qTExs/SrxUcD8dYIqMkVZmvPEkBXZtHAhCsTUng3jlhj7KYAoN12RFQFAwFmig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756913486; c=relaxed/simple;
	bh=Wu9M4YpIKT+vGWddhMj9PXdeaRh/syWvK69GFmoctuo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgaB2D0rDsxdWtSFLmntOLtz5N3YJ6rROTD544fm0D3+HICn5lyF+aqlpIOYi4N9DNhS8ZEAQ+ZL6r6IVcqyXEydVr5ZeSR9+4uOXHvmjTK5tQjq2ySxTbwidWiCK4vZUd9Xb0SoZFLtapzh82hYesyEQBEHT/c1nfi/JDMswnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 69DFC5B205;
	Wed,  3 Sep 2025 15:31:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id A4ED117;
	Wed,  3 Sep 2025 15:31:13 +0000 (UTC)
Date: Wed, 3 Sep 2025 11:31:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Oliver Sang <oliver.sang@intel.com>, oe-lkp@lists.linux.dev,
 lkp@intel.com, linux-kernel@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, linux-trace-kernel@vger.kernel.org
Subject: Re: [paulmck-rcu:dev.2025.08.13a] [tracing]  364ac25d46:
 WARNING:at_arch/x86/mm/fault.c:#do_user_addr_fault
Message-ID: <20250903113112.247eb552@batman.local.home>
In-Reply-To: <d1ee722b-eb90-4b7e-9c2f-2db7d3b33ce9@paulmck-laptop>
References: <202508211038.c93e8603-lkp@intel.com>
	<68044ea3-32c1-4d72-9bd3-fe2031669d79@paulmck-laptop>
	<aLebLoM2OQD+KPxQ@xsang-OptiPlex-9020>
	<d1ee722b-eb90-4b7e-9c2f-2db7d3b33ce9@paulmck-laptop>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: A4ED117
X-Stat-Signature: edbpmh7koa7ihpbptfnajxtn1rh8sapm
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18EpQL1l5ccl6ZK1yYxI4zY1u2/ZlT1vhE=
X-HE-Tag: 1756913473-414272
X-HE-Meta: U2FsdGVkX1+sSmI5A0f6i9mqzMWM+Dm1/Masy+yO8gz8iVvjkrw2zRAu9Ff2bL+0QtlTpjLz3BoQzdPuCAqOyr/Iao7vrlkpV/xOPsEXzfivQSUksb7+Wm+p7JJxnxqMl5uVwDHvHViYJiF2DMqo2g7/m6oOiAbYiVmIIijrEPqIL2p6x4gKRrbdMuOfjMDNtI25TtkYrRwc9iYJffVAsHKCmrQ9Iy+qkjRmivQOTcQ2K5I2ThMRS1G+9Pkg5HL9GVgeWQ081zGQX/kJ6JqamWEglNfsMPOoiWwStzeBnButUxuaB0GaV8kuu9NLQ2LCkDLE3kJznZkKwgWGcpgUbYsmq2QcGhfjRSLPV4l4LyaeikUEDfoWSA==

On Wed, 3 Sep 2025 03:31:31 -0700
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> > by applying the patch, the issue gone. but since you said this is a 'diagnostic
> > patch', not sure if it's a real fix. anyway:
> > 
> > Tested-by: kernel test robot <oliver.sang@intel.com>  
> 
> Thank you very much!  This tells me that something on the code path from
> the tracepoint to the BPF program needs to have preemption disabled.
> I will leave the diagnostic patch in my tree, and will be looking into
> what the real fix should be.

Was it a BPF program that triggered this? I couldn't get that from the
backtrace. Also, is this only a x86 32bit issue?

-- Steve
