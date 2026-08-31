Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B0639A7E0;
	Mon, 31 Aug 2026 21:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210485; cv=none; b=O9aDZokVlVlLibSIwd7SebnfpcobAWbGvAH/aCIlHvhcYBZEuwdE6eGIz9jnrQ+d0zfSZSD20i0bbArum6vryz13k+fnPSxgshdRdjswFk1z4T6tEwUam64BlUzV4LtrLElyRotJQMyeXoHX7T5VM4ANOjMCZASCMgbUOhiavSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210485; c=relaxed/simple;
	bh=gvC3ju/HglQkrViKAOWT2imoCWUjJmIa21VpRNi0YMw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Xcq1chaepf8hjG2kZVMZ4eeS6gPk7RqaLHKvx4klehR/JdciGsTxI7jL5h01tdfTIo0MK1AcvooWs3wfQ5gNYlXZq4ROYuqyvzuNuuFWeGp0mmCk1a+1Gihg8Ctzn7EANx0OyhBf3ZiGB5/sFDUikql2cMIcVfDI58PSmZ41/B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QFq+Dx1A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QFq+Dx1A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 526AD1F00A3D;
	Mon, 31 Aug 2026 21:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788210483;
	bh=4+em0ZEdjHu4ShaBifn99b5fw4zGxldy7vlQoFRY6+0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QFq+Dx1AcUrcJe6kRtR/xQ6mw8BW+MVhJ54B1eyd7GdKaT66AGYDwZFVA6uAv8d7U
	 3LXFa27AyLTuuoiB7ZQbdIcjZ2TYBavqCq4aWYnxpwnhfO9Jl7GkYOa/hIma6amLnh
	 XGcm2Wg/GUb/7TlkoVBYyMfM2EyoEEPOW7h/ftO2b+Sn0dsJ67OGLVOB3lsKtcKmUX
	 ZX3YKjLByDII4odnLdaOshdjpyrKXvQWMUACPk6SffDuPRMGpo51EaJzegbjpYU5mx
	 3nmg4KGuP64rEPMG0Z2TYSe4JPBZMMNJQiV33Kia+H6bvyaBwPZCbb7Qbj6Pb+gPsR
	 tiJG5RcXNYHwQ==
Date: Mon, 31 Aug 2026 11:08:02 -1000
Message-ID: <652a415f83f59c4f13716367e7081523@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: jiangshanlai@gmail.com, rostedt@goodmis.org, mhiramat@kernel.org,
 osandov@osandov.com, neelx@suse.com, sean@ashe.io,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] workqueue: Add telemetry tracepoints for CPU
 hogs, distress, and BH budget yields
In-Reply-To: <20260829230517.42468-1-atomlin@atomlin.com>
References: <20260829230517.42468-1-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Hello, Aaron.

On Sat, Aug 29, 2026 at 07:05:14PM -0400, Aaron Tomlin wrote:
> This patch series introduces lightweight tracepoints for these key
> operational boundaries:

Lai's address was mangled in the cc list. Corrected to
jiangshanlai@gmail.com.

Generally looks fine to me. Some comments:

- As the test robot reported, the open-coded u64 division in the first
  patch breaks 32bit builds. Rather than restructuring the comparison,
  it'd be better to keep it as-is and calculate the duration only after
  the worker is marked CPU_INTENSIVE. That also keeps the division out
  of the every-tick path.

- In the third patch, the timeout flag is determined by re-reading
  jiffies after the loop. If the loop exited because nr_restarts ran
  out, time_before() was never tested and a tick in that window would
  misattribute the yield to timeout. Please derive the reason from the
  condition that actually terminated the loop. Also, BH_WORKER_RESTARTS
  - nr_restarts counts loop iterations, not restarts.

Thanks.

-- 
tejun
