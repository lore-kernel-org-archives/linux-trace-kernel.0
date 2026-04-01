Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ADA188713;
	Wed,  1 Apr 2026 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053864; cv=none; b=UJEO2BDS5xz/FBDCdV22VMI0t5z3OkYG8jbmNpZjg1DBsL1NVxILSgCNXdGPa//ckNjMpm7zBu7ra1izmL7F4cdZfhHvoDsTagbJ5pqXYgnzu/pT95Jwlw/Y4xgOSFgLd4YRci/lL/VExdiu287giGqYC9wivrARJrBv6ktGZJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053864; c=relaxed/simple;
	bh=V1j85KccNP4vzahpbwrU5byKdmReoke5cVrfgNnXFCY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f4mrHqGiEMLXhtDsRg0+JiTgdX8q31KbqA9i2fcJpkFrGZUPpw5mcgkpQUgRyUIUZgeiToHtTdtXcxZkehr8GrkvRbIJXEqVZ1f5p7VfcfRmfYxC4QPBqIKwrGdd9p3Z4sv/88elIBRlXLC87QkOAQ1ZAL4t4H7+dLhVztFr7NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 61FE6C9507;
	Wed,  1 Apr 2026 14:31:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 27C5060011;
	Wed,  1 Apr 2026 14:30:59 +0000 (UTC)
Date: Wed, 1 Apr 2026 10:31:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, maz@kernel.org,
 kernel-team@android.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix trace remotes read with an offline CPU
Message-ID: <20260401103159.747ae168@gandalf.local.home>
In-Reply-To: <20260401025003.3258729-1-vdonnefort@google.com>
References: <20260401025003.3258729-1-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 27C5060011
X-Stat-Signature: hxiu8u6ua6b3ua88smrhfqxkp94uukpd
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+fRI2jEW0cBKVq5BotIDYbxuYgogb14tU=
X-HE-Tag: 1775053859-255540
X-HE-Meta: U2FsdGVkX196ci4253e2PZ2LlfWnoCli1tYKsShI+3lDTmajT/PzMgIPo7xqf04B+o5p/Z9N6vkRyHZUUKWOI3OnMYc6NtadV8kLdCP0eXD00EMyKxVrrCoDUG18ZzoB5d3o/A63l8/MKOEpFlSy866nTe1VEO5elrjJP/75xm3vlRtS6qi2Gr60PlcG4uwH9zMdiBXos4QjCuSd12A7OoCj3t0QgWuH9A7SJCCNYgUkWn+I+WWDePCvQkUUgij6i9LRncMZo/zXpbF1KaIOOGkL3Teu9sAhIDpwkQrDwbFhlkkiLf9QNTkB6+ZEa5i8y+2AJNKa4y0YViNWFQWxbCxoes8sNkuufhWuom62p/Yw5cVG3BDvEx+XmC4zmmuW7JqJukk+HLnPeZlAKnVX7Q==

On Wed,  1 Apr 2026 03:50:01 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> This small series is fixing non-consuming read of a trace remote when the
> trace_buffer is created after a CPU is offline.
> 
> It also extends hotplug testing coverage to include this test case.
> 
> I have based this series on top of kvmarm/next which contains the hypervisor
> tracing patches.
> 
> Vincent Donnefort (2):
>   tracing: Non-consuming read for trace remotes with an offline CPU
>   tracing: selftests: Extend hotplug testing for trace remotes

This looks fine to me. Since they only affect the new remote code and will
not conflict with anything I'm doing, they can go on top of the KVM patches
in the arm64 tree.

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

for the series.

Thanks,

-- Steve
