Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024C83E51DB;
	Fri, 26 Jun 2026 09:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782467692; cv=none; b=HZ5RDC1jCt3j+Oyh4sy3aaYkQHgpckGSPDyTZUpjkaCLCGBu25H+BKeiBXcsUQj7YI0FL7Kc/IV9GL5/sW6K2CjFJvTbVU9hKmF2oPbMk3bZwQ9RyN5rxkVaOXGrG2Ev85OYyWSetFpe6yT/TKGCCaYO6MX5+ai0ox+VlLQ4McM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782467692; c=relaxed/simple;
	bh=uXvVK93lYXu3zjvVhZv2LQjj/WLzgItxAyTy23ODDD0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GBlIkjc2RvEwBg3ypQy9T9itUuMtNWOAhU+C9/qa9uNJr8VfeG2Me4b/C7tW1p7+TpPP4zb2ABOiwCFr5hudtGkJR3+axi7cygrOjmvwU/XKWLu0YFtUeJZFG/sTqgsppES3ZVqY7/9fDwP32KXqbRMzKiRQ/xD09y6g5m+rDk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 93E84C1D66;
	Fri, 26 Jun 2026 09:54:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id AF6C117;
	Fri, 26 Jun 2026 09:54:42 +0000 (UTC)
Date: Fri, 26 Jun 2026 05:54:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Martin Kaiser <martin@kaiser.cx>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: eprobe: read the complete FILTER_PTR_STRING
 pointer
Message-ID: <20260626055440.76c28d25@fedora>
In-Reply-To: <20260622125815.7416792c020bd3d81c01e51b@kernel.org>
References: <20260615145500.2662456-1-martin@kaiser.cx>
	<20260616110910.e6420488b6a798d49951cde9@kernel.org>
	<ajJbkeK0zXb8MtcS@akranes.kaiser.cx>
	<20260618105227.c58c85e9cb19bce673d9a79b@kernel.org>
	<ajasLMUt_AMM3ztH@akranes.kaiser.cx>
	<20260622125815.7416792c020bd3d81c01e51b@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: AF6C117
X-Stat-Signature: ykuoypdejw9h3b7md4xd96ib1o47f5me
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/xOgBRXnC0wZRhJ5vUO5d1TliGYJmmChc=
X-HE-Tag: 1782467682-294626
X-HE-Meta: U2FsdGVkX1+UrhtUOB2G3EYmtqCMOP6dLTdKrP37IUSAmuZVTHnFA1y6PHGqK6AdLJ8KBBmY1EFAvwo6777ypoLwkUy3OVBIyt0j4FB9f/cdvDffUT4ce/Ak49lkiqSaz4DnYX4Fz+dzGAnXUZIF5atwEnON3DtyDbuAnylPwJK8frKWL5oHrvm0oR72RVx6e0klUnBSYVZnyIbOXCQw0pkCSZw1gV2P8mcNzSGwUZhHxio6TAeRKRxu7JUb+kCBTC2o4u/g2xbHFdFhIfjXRskmqRVoG12hvrzUuNHVG8jJRSMbAS4k5hd/iBJqLRFjYs1Rgdybb8sZXTkss1p18hjJYMQlV6Vi

On Mon, 22 Jun 2026 12:58:15 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> The problem is that the event does not provide the information that
> the string is in user space or not. But actually, for syscall events
> all data pointed by syscall parameter should be in the user space.

I think we should make this work then:

  echo 'e:open syscalls.sys_enter_openat file=+u0($filename):ustring' > dynamic_events

That is, to have +u0() say "this is going to be dereferencing user space".

I'll add Martin's patch and see if it makes the above work.

-- Steve
