Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9771C2D130A;
	Thu, 11 Sep 2025 14:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757599447; cv=none; b=eGIVWe3DJBeFMltzm6buqewshur9Ufj77apxfa18G06Q0VASPrplozt5bs+IVuOWj5jtO88sl2MF/oT1HUIsu2razqG9HGhUHQJX6E5QzU/hK83ec1nn6ym7TgM5hdjcwOsqRZxwS2OqjxeF3q7ag9KkFJ/GR6NHeytGwbEA70Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757599447; c=relaxed/simple;
	bh=tqI20KcrF1915HcKwwUWQYY7UjVDMfBrvy90nCsN7l8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IPML1vYxqsk4HZoereNDILDJz+4g954/JBZBlsc93F/8C5r08Sx4mAWJuADAFDLDDIB5zkh0bPkPo4WDacy/34f2hU+2I/K1ZoGNndXmNADkhLE9jMOgV9ejjX8yfP7sZcPVVbkou7uL19YL+hCIFQnP02tdhrFxzcFJGNLDJPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id ADA5B1A0219;
	Thu, 11 Sep 2025 14:04:02 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 91DA320024;
	Thu, 11 Sep 2025 14:04:00 +0000 (UTC)
Date: Thu, 11 Sep 2025 10:04:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Oliver Sang <oliver.sang@intel.com>
Cc: Pu Lehui <pulehui@huaweicloud.com>, <oe-lkp@lists.linux.dev>,
 <lkp@intel.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <mhiramat@kernel.org>,
 <mathieu.desnoyers@efficios.com>, <pulehui@huawei.com>
Subject: Re: [PATCH] tracing: Fix missing errno when zero parser->idx in
 trace_pid_write
Message-ID: <20250911100452.15fb74d4@gandalf.local.home>
In-Reply-To: <aMKHBwzgqHOhILUQ@xsang-OptiPlex-9020>
References: <20250821071721.3609109-1-pulehui@huaweicloud.com>
	<202509022339.ae20a8bb-lkp@intel.com>
	<20250905150312.02bef848@gandalf.local.home>
	<aMKHBwzgqHOhILUQ@xsang-OptiPlex-9020>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: majb6bh3sxp9qjj3i5jd65p8acnth5un
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 91DA320024
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+y1z96nmL7bBDJnNaMyrFZJFjb8YeQLbk=
X-HE-Tag: 1757599440-802295
X-HE-Meta: U2FsdGVkX19nT89Y4OfCtAhbVEPZISwHxBiWSohK2bdRoFHveLIWwXkAaYe2FgooIT+63m3dc1MNMUmJLpI+Q0FYtQTLfQn6s8KfaH9ffKT/96jfj5XEmMvSProRgxYExS/oLUrtJn9Zg/NmeBx537NgI8UcJs1C/UjmUL8XHeIasbDwn0eO2ocY55v/zH+hOEUMJmcRhROkSEowZNlSWKHoluwY3tMLc+zsWKQ2ZSQHvZpNtJV7Ba6+ONzEPJZV2VcOJMS4bfWNxzpHLNn1yZ/7eknAC7l/cI04t0HbeQSevRddWgfMo8Y7WX15gujlLSCc2kZHrV83LohL+mEYzFrARrwwTXu6adRqg09YpkRgCBmGAOyyNcRoKt1TS+3vBLkzxvTXskI=

On Thu, 11 Sep 2025 16:23:35 +0800
Oliver Sang <oliver.sang@intel.com> wrote:

> > I have no idea where this "perf_test.sh" is supposed to come from, and why
> > it doesn't exist :-p  
> 
> sorry for inconvenience. for this "perf_test.sh" issue, we pushed a fix
> https://github.com/intel/lkp-tests/commit/3ab6496813796e537d277242d220c4571790a363
> 
> however, we found there are other issues which block reproducer to work out of
> our cluster env that we can not resolve shortly.
> 
> but if you have any debug/fix patch, we'll be very glad to test/verify.

Nope, I just gave up on trying to make it work.

-- Steve
