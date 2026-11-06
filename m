Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.15
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981523;
	b=w/M7iedMOSkd0BQSYYwuHMOy6kvUKPK08c1YL5Nl03KHGkXqC0Rl4u8qHCy3nPphLqvT
	 Syaz37pO+UyJeojozMpQmnymNayu2EdS3AXRPiJI5jbs+ew1ORnJBoFS2jvGD6z++fgpi
	 fZQarUrKr/TtxH9AsbNDmLte2tQp4tp+XLFsY3glKl2xQCud4TSYrlWipa8M6dLgZOHRS
	 npAj9oGnoI0lAXIKyvMtHe9JQAXgKv3kY6bZamO5+0tFZqRYiFXoXbzMFIAwqvmYMwUjL
	 X25Ldt397q+su11LLRI68qrVGj8VH9zymlzp9pTNW82sFgarOUYY6feYKgZqXCnSFTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981523;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=u4dADfwBHaP9Z+trAd/cC1BAnQN/RgHMjjBme6z20L0=;
	b=am7NyczQPO7Pj5WDFC+OsetVr6//ozuod2D8K7fEXinB0ADuu5bCCA5+j6d/nixC+E0c
	 9eRqLTZua0rPfrif56EZv3MwckNpAg3u7jYI7WYGZ41vy6caJHdSjsaPDz8J0XYkPzt6v
	 6zOYI/JTo685ZkGy+HkjCO6NJwxVFgogN0G7DXUa8pVd4VBi2XYyAGEULixygwq9zVq0D
	 oOZ5L9pOxTKzTafQutiSZo4q+kET8pZVlIJiZJ6ibgEQ9v2FRQlR3RUOPlgWS3BRQk/wk
	 JWL1Vfaap2gKZa2t6rwpxPTtGH7R57sIvFCCBChF+GSK6D7me1Dq4RXCFMCJ0HwGz/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=XXPykNJ8;
	arc=none smtp.remote-ip=216.40.44.15
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D2D606A32F;
	Fri,  6 Nov 2026 16:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85D2D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=XXPykNJ8
Received: from omf15.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id A0DD61A0101;
	Fri,  6 Nov 2026 16:11:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf15.hostedemail.com (Postfix) with ESMTPA id 4E3761C;
	Fri,  6 Nov 2026 16:11:56 +0000 (UTC)
Date: Fri, 6 Nov 2026 11:11:54 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Mitch Hen Chez <mitch9654@gmail.com>
Cc: deduce@gmail.com, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen
 <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Stanislaw
 Gruszka <stf_xl@wp.pl>, David Laight <david.laight.linux@gmail.com>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>,
 linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ftrace: Drop weak function locations of modules
 when loading them
Message-ID: <20261106111154.0e09925f@gandalf.local.home>
In-Reply-To: <CALr3rD93RT_=w8VB6aKfuV5crbwXK4Tffq9bLD=eJBj07Tv1=A@mail.gmail.com>
References: <20261004-ftrace-mod-bsearch-v2-0-c1de73e72e73@gmail.com>
	<20261004-ftrace-mod-bsearch-v2-2-c1de73e72e73@gmail.com>
	<CALr3rD93RT_=w8VB6aKfuV5crbwXK4Tffq9bLD=eJBj07Tv1=A@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 4E3761C
X-Stat-Signature: u39macfkr4u77ts611ireors5td7cx3t
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19WZpY2CziLb2q1uamnYVWTswP1sdOp1K4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=u4dADfwBHaP9Z+trAd/cC1BAnQN/RgHMjjBme6z20L0=; b=XXPykNJ8QCC8JloyhyOflNzNt9HDMDXBWwL85CYMqFzm6U/6QuMiKvZzr1+F6mM8w4A+qv1R1ZIXhitiPQsMdx9GPo6NyXFD2yVSXqWY1WqW9uCTGNaHXM2GmjJubFF0aVmVZlupCSCPxFpjg5FpGoxCol+XB4JfG3+SG2AcHSo=
X-HE-Tag: 1793981516-592299
X-HE-Meta: U2FsdGVkX18tIJgVk2Kh8K2BGR56MnLRhOpGzmX+90HkUSF5JlssVjnmb4dK7Y8yLj9lOBDNJA+cx1YCddIqXASgGcV7CozyG4tMgaCuG/OGBGL3PvQmXs3oVaYcP76Ov7g3eTjex86XeEn1JE6/457jMNjHmJFgyG6FNU2tDtt5q0wF+mJ1uFhUfOtk2cU/riThtCs3hUkanKbRfqe51n0Eko7JLUusixRGetrttQzGIfp4tFV6+UQxB6TZOAaUYiJi0moZAHXukQc3dgWZyvfoLEwTHZLcWH819qG1aZFlD3sGLPEJNL4X7k01/3J82AiP88Kq6YcYLcOaAnRHwg/58GG3S6l8K7/dJBMZzxIhbQWdHLihIw==

On Fri, 6 Nov 2026 14:13:56 +0100
Mitch Hen Chez <mitch9654@gmail.com> wrote:

> Would it be possible to have another review pass on this patch? I
> don't want it to fall between the cracks :)

It's in patchwork and you can monitor it status here:

  https://patchwork.kernel.org/m/20261004-ftrace-mod-bsearch-v2-2-c1de73e72e73@gmail.com/

The workflow is:

  New				- first submitted
  New delegated to someone	- Added to somebodies queue (in their TODO list)
  Under Review			- Added to local machine for testing
  Queued			- Uploaded to linux-next
  Mainlined			- Added to Linus's tree

It currently is just New delegated to me, which means it's in queue behind
lots of other patches :-/

-- Steve
