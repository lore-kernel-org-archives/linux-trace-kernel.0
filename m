Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECEE38332D;
	Thu, 21 May 2026 03:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779332463; cv=none; b=lAz9hq0ubwdYM/uTN82HEyEfcyM6Nn2c1cAnbM7g4mSxt06xUctiYm3lizcVTH2drS0LCjAnXqpc6Szitp2l4cHeg4+ZxBKUYFDTAsDL8ysCbYWTJqDhhwCzFnx2skqvfbdvDciFAlKBVL/mwGfRsfqVVrm4QVFdaS19HWW2T8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779332463; c=relaxed/simple;
	bh=T991G2fMapskZ5Th7vbKYPffTF+R5JGplcQjgzMS3qc=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lz6RzykkMTWvP5s4WEqQLQTMbZ2dkA8xIXcmgowtRj4NdhUHyDHjmhAccf+3kfCGgpb7Ld+Fi7Yqx7D3ZtR00bvYw8ZOiBuKT36hiGU4JDBxb9m5qx5C4XL0eDTP7bGpqgq8YN6Vz/ys0ZRDTAphsKgll6LLt6hW13mpdZKKGBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id AD5111204B3;
	Thu, 21 May 2026 03:01:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 39F4920016;
	Thu, 21 May 2026 03:01:00 +0000 (UTC)
Date: Wed, 20 May 2026 23:00:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re:
Message-ID: <20260520230059.52f5cdb6@fedora>
In-Reply-To: <20260520184716.199133347@kernel.org>
References: <20260520184716.199133347@kernel.org>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 39F4920016
X-Rspamd-Server: rspamout06
X-Stat-Signature: k15t1pf7mebiacgiegir6mtcctsp8exh
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1//JY0nydRGfi5ZIDloa0NBteGmBdBd+jw=
X-HE-Tag: 1779332460-122818
X-HE-Meta: U2FsdGVkX1/5S4Th0AQzC1dKCCmdZR6QqrodFGwXphi5KYHL2U35lMs0pEWmN3GOdpE4Z0rvtcyRyK7zEBDsrHiG9yboVZBSYNHuWh2N68FwvCyhFTFUwywO1r9I+tlXQqbc2bl3nqbH3W9FbJlxz7aNc2TcVLvU15g6xgBeSqoG/0O9TmDi5mFKa35bZ7X+n3yMbM0HFjCjjTyCFrGOV8My2RNjbAl/86cad0GlgmxMDeYuW+no+bA6tVIew5+H+iaKHRV/rYH00xQyOY4ZbE/aRHB34t15RdS9Mln/JZGZ7eP0A+Url9vgKbhI7GqY


This is what happens when I have a typo in the quilt send mail "To:" fields.

[ Yes, I still use quilt to send patch series! ]

-- Steve
