Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BEF5A7B1;
	Thu, 25 Jan 2024 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190516; cv=none; b=ZV5/BPtlifG2m+m4KFSaxKlGdpSCIxyd850nKd5AfRoOAo9ZhxzkhIWhM4cRCFIayRYXumc6Mwl6JmkRBNO3cAIeZVBYWJNxwDzcamItpHZjqCwdabC3BSAQmOL2v2xjnvbduI7ejbT5V/OH4b1lFlFI4eNirNlo1BhDHbV1f0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190516; c=relaxed/simple;
	bh=tSkZ8dfl1rFw812ykxPPPM1f5phy5tOyipZeedPwgBA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jAdD4GzFd2DWmpH867xH+7Ww/XjfMQV4EHLjbPoJg6BNOVceRpOAx/ghpN+6HffXE24ytxfcS8jCGxHbdVuWGO02PJ/PO4NWh0gdGPdiaIKqKHMm1sO8arFwGNpi9CgWklcpWU+EcoibfYWf717ZQcjEQ3rdkePyp0WKJDZasPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=oUgoM4ty; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="oUgoM4ty"
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1706190507; bh=tSkZ8dfl1rFw812ykxPPPM1f5phy5tOyipZeedPwgBA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oUgoM4ty0scNYphlQQTkycgj2bPHA6Ud9h+Fb/OMJs4zxeZvJH1wqTmoF7f8ebRlM
	 Zm9w7P5jmiJq0lJ+Tm3TsgfMjSe0h707S2v7cz9LFl5NyotSDVj/6OlF7mqiS5aEUI
	 bZtWujGpGJeY0Ez96VoshLE7vJiVFfPTcbrpVNJc9swnOEejELn4vjn/R4vjnWthWa
	 ugRkbYyvMY4S9mGvJQkBeoUmMoTd4CL3IDlYLI0t+AAVn88DhLXtEoRP3Gmc2FSkEx
	 tpVocBOk24RdLkoI+B2CLKHhKM1aq6//ZPfLSzZNxhmjfXUFYZrTvVLPWrem7rDkE3
	 98/xWeBMOmDlQ==
To: Ubisectech Sirius <bugreport@ubisectech.com>, linux-trace-kernel
 <linux-trace-kernel@vger.kernel.org>, linux-kernel
 <linux-kernel@vger.kernel.org>
Cc: johannes <johannes@sipsolutions.net>, kvalo <kvalo@kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN77yaZ2VuZXJhbA==?= protection fault in
 ath9k_wmi_event_tasklet
In-Reply-To: <fb3ea26f-f9b6-4107-bb03-ca4893f0495f.bugreport@ubisectech.com>
References: <ed1d2c66-1193-4c81-9542-d514c29ba8b8.bugreport@ubisectech.com>
 <878r4e4q69.fsf@toke.dk>
 <fb3ea26f-f9b6-4107-bb03-ca4893f0495f.bugreport@ubisectech.com>
Date: Thu, 25 Jan 2024 14:48:26 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87wmrx34np.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ubisectech Sirius" <bugreport@ubisectech.com> writes:

>>Hmm, so from eyeballing the code in question, this looks like it is
>>another initialisation race along the lines of the one fixed in commit:
>>8b3046abc99e ("ath9k_htc: fix NULL pointer dereference at ath9k_htc_tx_get_packet()")
>>Could you please test the patch below and see if you can still reproduce
>>this issue with that applied?
> Hello.
>  I can not reproduce the issue on the Linux with the patch applied
> Ubisectech Sirius Team

Great, thank you for testing! I'll send a proper patch. How would you
like to be credited with reporting? Just as 'Ubisectech Sirius
<bugreport@ubisectech.com>' ?

-Toke
