Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3606843634F;
	Thu, 30 Jul 2026 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785418437; cv=none; b=aA4w3EmGVVJrGtHVUNquPAYdLE/vfTKQnFKutyN7bCtYgDuGX8OmBrOpcHL5kv98iUVyFnHGoF6W74y4rYNSfUxWG8S/nzR6IJdW8wRP1AjObooccmZfzD60BoFfiqEg+vebYcN4oLlKto8szd6ynJOBNJHga5cK8NY8e+5iIho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785418437; c=relaxed/simple;
	bh=nURDG+KxOJQEKIE8oxoja9pS084TI3aPYLKSLUPcqUg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sg9XXCfH3SDJxehsNBF71xTxodqHilyh/h5BUfN5OrHUidMmtK6BcAfJKMbJC6X4v/aO4E3fowl3rX2E7UICXVLBEOzGNJ6CPLBjdT1hkOSY0Yo3EAbJ4gtXexq1yz9wJU3NaDMaJlydqCnXQrm06NKyJ7xBUxZSEEV4rHTA2Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay01.hostedemail.com (Postfix) with ESMTP id 1A88E1C00DC;
	Thu, 30 Jul 2026 13:33:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 30D1D20032;
	Thu, 30 Jul 2026 13:33:46 +0000 (UTC)
Date: Thu, 30 Jul 2026 09:34:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Michael Wu <michael@allwinnertech.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Namhyung Kim <namhyung@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] tracing: Fix race between update_event_fields and
 event_define_fields
Message-ID: <20260730093423.7b4ac0c6@gandalf.local.home>
In-Reply-To: <08216429-43ba-efc2-f6b1-459210d07b02@allwinnertech.com>
References: <8147bb04-b890-f18a-9cab-48b712f54856@allwinnertech.com>
	<20260730173157.e756d8a021d827b7aa9686cf@kernel.org>
	<9613182c-6299-3c68-5afb-2bf8d9f90f03@allwinnertech.com>
	<08216429-43ba-efc2-f6b1-459210d07b02@allwinnertech.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 30D1D20032
X-Stat-Signature: 1knqn3atdfaoy3bhxjobaoq8o6axjgyz
X-Rspamd-Server: rspamout07
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX191uJvqgvpMWjKnwiWpJc0cId+8Be0igiI=
X-HE-Tag: 1785418426-758310
X-HE-Meta: U2FsdGVkX19MCiYXXuJex6d0Spii32dmThbhCZJ8VtJlGAINk4klxtlML/L2ZFHHuzU3p+1Ytpu6c4WfnDRda54K/JcHPOzdd1/m76XAHxXR1Km9pi1zMUHafASvt4uQaNirP1k/XBBIKi/4+l01gg9hQ55oQCWkIs/1ICY2L71P1ghSw3Z1OfObj0+b6DeuPRda2YTrX2SaeVzpiyQrJN9jNyLVMdhFl2fcXY/Hi7pcNtafOiFOYFpByO8pWwfuzlcCx6agCik+67D01GIrdjlMTzzD9IRs6uZS2CS4FotNIWIChwgf9HdHWOYQLyb7bBDy9P4q1B9FTeFC2/oEBUhIJwIL8H+PWn5L7leS4502kVq8cXDNVFSREf9rlGs4WyHufsTvojlW/GoPvvNPvA==

On Thu, 30 Jul 2026 19:13:28 +0800
Michael Wu <michael@allwinnertech.com> wrote:

> Hi Masami,
>    Thanks for the review. I've rebased the patch. The new version is below.

Please send this as the start of a separate thread. Automated tooling works
better that way.

Thanks,

-- Steve
