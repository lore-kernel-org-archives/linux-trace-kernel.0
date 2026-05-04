Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F0535AC14;
	Mon,  4 May 2026 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777885684; cv=none; b=Jpcwj1pIWVBBgSfFceU0PQqzRd2A1GiOy8PL7c1jR2O3xV9DdZFnIVeib8f8asjutcHH1mAIzEAf/Ky0Fvv6/y8X4A2qFJsZ2KdgAzn5nHKZN9m91HJ8bT+Txp+J/X0/8wvYuLKgk3jwMsPx/GJABOvtwx/bcpiUm9WwwqRhVxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777885684; c=relaxed/simple;
	bh=DTxE1j22BXfV97bUFcRIShbJs68m4szwHWrGKNRMA04=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LeF6SKGqeTryvuN/cKrSmqgJ2e0dmireS2BGviI6NwMpuavZjpsSN9pRWZSIMG8vlJkxYnCpi8m341bGYIiGMtsRie+tdRu0E0jJcl9tDbzZFjs0sRkbD12BUYQ/IAg32/iAYY9Kr51C94BCNOkWQM1vSBJ4e5gojz4W63mXvZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aBhzkYGc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=49EzWWNc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aBhzkYGc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="49EzWWNc"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1777885681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OybbERpQeydZe8FtF9eWXnY/wdl1o9b3iZeBdSpRQDM=;
	b=aBhzkYGc9Z6Mp3cFKkkLNZB1hi0wGGNHOtBVRxCQmQqvzXNpTw9fRTJZenS25SxCYd8Wq6
	KDoRbiBNRDqAOAsdMD2A5zaA1rhhvUk8ENpJPweOVFJ0hbRnsxIxbz9/WejS4Zc4l5ktCw
	RGmM5zCIXboFjy7Nk13KfceR9DYXSnOj2i2qD+pFKrgVSHbipw84QnCovFlW6goLJW8F8/
	lhSoY9wdNV5x+QVSP46yaLfTxE1df2fp7VSDaD3qY/4lgDmsRDQ3tQskJZgaz5XyIE+pbc
	bnm1HFir06vqKiwc4FTudHEv9WlpDkX9cQr406/emN9NjsEzNrfOEdfy+Igc3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1777885681;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OybbERpQeydZe8FtF9eWXnY/wdl1o9b3iZeBdSpRQDM=;
	b=49EzWWNcuQhKBLXgL5c/1w7HejrStMkhuP76Dwok4wxOYmm2bZMqSswNcy2bKFNxoTZwI5
	u6NfJTIsqQSbkXAA==
To: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Weissschuh
 <thomas.weissschuh@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, John
 Kacur <jkacur@redhat.com>, Wen Yang <wen.yang@linux.dev>
Subject: Re: [RFC PATCH 07/12] verification/rvgen: Add golden and spec
 folders for tests
In-Reply-To: <b12301e81688e1795e0f73adcc33a9e6dca9435e.camel@redhat.com>
References: <20260427151134.192971-1-gmonaco@redhat.com>
 <20260427151134.192971-8-gmonaco@redhat.com> <878q9z1up7.fsf@yellow.woof>
 <ffb994110f4ec8165aa5a3e7cd83a57beeb609f9.camel@redhat.com>
 <8734071s43.fsf@yellow.woof>
 <b12301e81688e1795e0f73adcc33a9e6dca9435e.camel@redhat.com>
Date: Mon, 04 May 2026 11:07:59 +0200
Message-ID: <877bpja6fk.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Yeah, that'd do, keeping in mind the label after a \n can be different (HA
> invariants). The invariant parsing should then make sure nothing else appears
> after the \n .

Thanks for the info. The new grammar [1]:

class StateLabelParser:
    grammar = r'''
    label: CNAME ("\\n" condition)?
    ...

will handle that nicely.

Nam

[1] https://github.com/covanam/linux/commit/361efb610ba7c06b3668a953a6847ea80453c2e3#diff-904e482d5fa6374ab7ae9356df1340da53da564b16c81f3d932c0ae521fe2d13R253-R254
