Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3249433A5;
	Tue,  1 Jul 2025 00:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751330070; cv=none; b=f5ZveWfhA5vMPkd+v5bs1IEy/SCNi4JaV9Umod+bJJxTx75bpml3Xj8HWO6OUprLb+5lBFPuCLVOiVMr/CMmaESYdjdZNPT7hETBhOQ3o3/DswcS7Dwi8vj2BY5pI4gkx5Y+9WVEJjfl3bXgnNSkVzQw23brW4MJv5E5OEa4ZII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751330070; c=relaxed/simple;
	bh=soofGfktdUTzhkeLri62x3nc+7vffuBNlzyVx4ZXkKI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFCA0DEhPrTIkBgzoy+59Lel1p13b/R57+ah5NLaiejfQWKYOO8ua0dOeDG+x2Vf5yNWmrz2L5W5G55h5dDYdVKNUKPjWu9rGsirpGJLFrBjuNskomHvQMxakDy5wXzcv5ZiZIAzd1a95ut/IBa0ZEIAm4czqod5KhoGOj53jOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 0D5C8140213;
	Tue,  1 Jul 2025 00:34:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 3B1B720026;
	Tue,  1 Jul 2025 00:34:20 +0000 (UTC)
Date: Mon, 30 Jun 2025 20:34:56 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 john.ogness@linutronix.de
Subject: Re: [PATCH v10 18/19] rv: Add documentation for rtapp monitor
Message-ID: <20250630203456.5619393f@gandalf.local.home>
In-Reply-To: <18984a62a214d18793b04cce98a4498a4813ff85.1749547399.git.namcao@linutronix.de>
References: <cover.1749547399.git.namcao@linutronix.de>
	<18984a62a214d18793b04cce98a4498a4813ff85.1749547399.git.namcao@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3B1B720026
X-Rspamd-Server: rspamout02
X-Stat-Signature: 1egrhocr3kg31i6ezu4ahzh9pe6zh87g
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/lVfUDTyAYSDNZKVoB8OEQUXTvUbr3vno=
X-HE-Tag: 1751330060-542645
X-HE-Meta: U2FsdGVkX18p/Om28DO7EaIfiJOoWPiMGv7BMMifbIoZU37wdUUgSpqgD2BvUIMFVUzRAeR1juAwE7/wfl1uqLPQUoujTvCuijEZ8f/4FjdUniM5kb8cJwQq5sTRD5VvWAM98R4kn0kYg4r3WrKsyrjyrJEhdUWy9K0r01rd3C3ZLFzGrkN7EAk1e4c2I3V2WB7LppdYDS5sX00UCa+6LniiS98b5mPLdlOSdty1cfJfMICqpT6hjcUwb+aIdgwUc3lxI4pwPvHN7vSxLZ/MSNYDiqSU+OomazMuPoYfzD2fvjVBFgYKl9DVXZUjPbK1

On Tue, 10 Jun 2025 11:43:43 +0200
Nam Cao <namcao@linutronix.de> wrote:

> --- /dev/null
> +++ b/Documentation/trace/rv/monitor_rtapp.rst
> @@ -0,0 +1,116 @@
> +Real-time application monitors
> +==============================
> +
> +- Name: rtapp
> +- Type: container for multiple monitors
> +- Author: Nam Cao <namcao@linutronix.de>
> +
> +Description
> +-----------
> +
> +Real-time applications may have design flaws such that they experience unexpected latency and fail
> +to meet their time requirements. Often, these flaws follow a few patterns:
> +
> +  - Page faults: A real-time thread may access memory that does not have a mapped physical backing
> +    or must first be copied (such as for copy-on-write). Thus a page fault is raised and the kernel
> +    must first perform the expensive action. This causes significant delays to the real-time thread
> +  - Priority inversion: A real-time thread blocks waiting for a lower-priority thread. This causes
> +    the real-time thread to effectively take on the scheduling priority of the lower-priority
> +    thread. For example, the real-time thread needs to access a shared resource that is protected by
> +    a non-pi-mutex, but the mutex is currently owned by a non-real-time thread.
> +
> +The `rtapp` monitor detects these patterns. It aids developers to identify reasons for unexpected
> +latency with real-time applications. It is a container of multiple sub-monitors described in the
> +following sections.
> +

Again, please limit the documentation to 80 columns.

Thanks!

-- Steve
