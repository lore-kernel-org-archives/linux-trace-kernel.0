Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3984D2C0F8C;
	Fri,  3 Jul 2026 19:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783105773; cv=none; b=g7ruifY6ypUps8GtsSDXKity6FBsxHaZCf20FrhGeKE+uXsTgxGqOr4wB6RuS1NeQ+UvhVjuczij1OolVQJIks/JvGxo6K3JRC59SaEmq2M7s4FJVW/8szhFI6Mzf8sHQrwJB0Eaob6f4SB5FlkALD914vHgb8tXxgzvZQ8LYSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783105773; c=relaxed/simple;
	bh=898xRicWKmp1W+pbcjU605Wf9ASc74p+xM3ucOECEA0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtuufwHsoqoBkg/oeDUqfTWgtxCJ7qQDjEGJlAnorNzhFlIhU9v/F9PtGOd9uZ39ObfZTuwdaEKM3jWb7BZVybILo8h+saastBFnhrizhQnkGctBMSjZnMC5LrdxS5LKuWE2OthooilDpavy+u0qSgS1RklFbmhyZtMhmD/CHug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id BD4541C1DA5;
	Fri,  3 Jul 2026 19:09:29 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id F3F9B20029;
	Fri,  3 Jul 2026 19:09:27 +0000 (UTC)
Date: Fri, 3 Jul 2026 15:09:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: linux-trace-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Masami
 Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: Cleanup event_enable_trigger_parse() by using
 __free()
Message-ID: <20260703150933.3ce014b0@gandalf.local.home>
In-Reply-To: <360ba00d-352b-4fc1-9bfc-56d29b317f61@web.de>
References: <20260701174829.67ab8a33@gandalf.local.home>
	<79106214-b341-46ab-8810-a206ce8fad29@web.de>
	<20260702165346.035f8eef@gandalf.local.home>
	<d8f33e0a-b378-4dad-92b1-9ce2098c04f3@web.de>
	<20260703114233.56f0c864@gandalf.local.home>
	<360ba00d-352b-4fc1-9bfc-56d29b317f61@web.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 743usu15t4o9osfs8s8ezu4d3wqipo34
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: F3F9B20029
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19jE40ei75KLpIwjABDvYUDG7X3poM8e1g=
X-HE-Tag: 1783105767-520569
X-HE-Meta: U2FsdGVkX1+/a9cn0UPsGr/M8hDYV0Zd21IbXxkFwtRWG26Nu+SvH06aj47MDTfZrMY+zyw3rbSKUn4sDy5nqTwy1Ggq/U3X30ZB0vWkK74i9YRMKYQmyzTYOCzuF718c2rWCdgktu/9YssLcVK8GD2heFMoVo/SfEXRanD9nnzGppr/9KB+i4lJcOX7hvMc8nTl8L5a0sDULESaNvffvZc1nn4761X7+jSFEgQKt08px07Nf76eCUHjB5ghwcc9P6+ZdlB5WbRbKJafs+S4WMPcrKJ36+UdRVxJ5Yx0y2eYfF8kHOsam5Yq/fwP/MD0NmZhHPks+pRrGsg36rQ3zpqvUDiKsE4DkAC3JT9S5aObe5VO4snW5w==

On Fri, 3 Jul 2026 20:37:09 +0200
Markus Elfring <Markus.Elfring@web.de> wrote:
> Do any contributors care a bit more for involved technical details?
> https://lore.kernel.org/arm-scmi/20251208020907.5476-4-krzysztof.kozlowski@oss.qualcomm.com/

That example uses the variable in a specific block whereas this variable is
used in most of the function, which makes it appropriate where it lies.

-- Steve

