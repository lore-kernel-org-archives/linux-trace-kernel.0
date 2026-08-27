Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BD8480974;
	Thu, 27 Aug 2026 15:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787845061; cv=none; b=mGR3dJwVaCmLCrz9qkDE7/If3qLZpbtM3BoOc0Mvx11z+V47yHd8JA6OphibcCSB6rDlYzXe3s4EzWTDIcsx+uq5GmAaP/l3teU8/Hzte25qvq5CnJDcon72NQuPVtvMOqk2X9pDSCvCC1hUSH8evuJWhj0337TItbgiNSSqKVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787845061; c=relaxed/simple;
	bh=7kNzrzrR628KWy4wv+ht+DrCY9yJ3kaAaVVyyCEwKtU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N0JNTKncY3W/2Y/Ed07aFRdomiE76Mn1QLsUJf9cYIrI9jUEDSjAPWL5Tcy8WWEhdyRtPb8sKHx1MYKQbTCfuyVw0M5OzMU4MCi44igXPMQ5VAUrArri1XCGSGsrfCVECWdnFPrP0ep9UmRVxDd0Wflo8x6b9bIGGnwPaEs2+wM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=FONL3r8v; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="FONL3r8v"
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 278BA1A0482;
	Thu, 27 Aug 2026 15:37:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 1FCF02002D;
	Thu, 27 Aug 2026 15:37:28 +0000 (UTC)
Date: Thu, 27 Aug 2026 11:38:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Xiang Gao <gxxa03070307@gmail.com>
Cc: Xiang Gao <gaoxiang17@xiaomi.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lorenzo Stoakes <ljs@kernel.org>, Gao Xu <gaoxu2@honor.com>,
 yinchuang1@xiaomi.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC] tracing: aggregate ring-buffer memory statistics
Message-ID: <20260827113815.0a0e37fb@gandalf.local.home>
In-Reply-To: <20260825141015.3539553-1-gaoxiang17@xiaomi.com>
References: <20260825141015.3539553-1-gaoxiang17@xiaomi.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: gz36t9ay3xuqryqmakdzi6jrhuz5y3wc
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 1FCF02002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Fp3vd/XZK9ZzG0XmgGs7MuhfPTImg7hI=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=B5sy7Dnu1doW9a8EFJ94rs455TnrWVmiKgWn+uT2Rbs=; b=FONL3r8vVCTADP1UST9B/fX3+5aKKZ7xbiAlpU42sd1V3VwC35sjsDYOBNEx4+EIUrx0rZytYRZ1t4hCbWPPIGvm9y9arUuUFAgQKEYFtcGjAVszth4+3rz8P/xaS2PLeteHewFcWR+RYYmtliOZ0sfuJoBkxL9Vns2ewGsGrMk=
X-HE-Tag: 1787845048-712360
X-HE-Meta: U2FsdGVkX18whgPuv0OOvjJempj+iG/EOSFqn+7N5rNU8fC7dXwUwav+ugDIJ6Y0Z9NvMXRtR7FcDQpOja1wgFmR5m1Q1i6Ql91tZDcwQjTFOVfUTNkZwEqNDIdhGFEuWj6lLZWKInkjLyPKrXvq8QPHGBEtXjaokSO4AHEFAMJkJA0WfEpeXJ3FThNsUCmCGbcHtY2P/r3lxI3XG0EV3lYM3TMQxZXglw/wwQUS/s35TYrWfMebhoiyX3mcg4BzOeDT51KWiSFJer6mne2uUgVQpGILuf62aD/CBOGMKlVDKD4RFGcDs6ydBGTcTlzaqXlCbTmUIhJsqnpqjzU02nGzRRwpPg/p

On Tue, 25 Aug 2026 22:10:15 +0800
Xiang Gao <gxxa03070307@gmail.com> wrote:

> Slab-allocated ring-buffer metadata is not included.
> 
> One open question is whether reporting page memory only is acceptable
> for the initial version.

As supposed to what? The meta-data? I think meta-data is also good to show,
if it is allocated. Maybe as a separate line item?

-- Steve
