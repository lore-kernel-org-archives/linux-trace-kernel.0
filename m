Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2CC19884A;
	Tue, 22 Oct 2024 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729588900; cv=none; b=bFlwjrtYvTcG8cKt6smPZLwCtPilEh+FYUT/rZToOlflT0CgsJUYLLdi2SReO6VfzkRJ93cxoKoXTTMWnVPNRN6PhP2mZsxMwBX5M9Nn2IzDwvdf+24mKTNsBvsU8OmJzk8xe9FlUrzzvK/e7BLM9afKB2CKgh0EwPLlhG5xtNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729588900; c=relaxed/simple;
	bh=4fjLCk9f33VhcCmTwP8POXGDRA5gvw3F5ePy74UKHNc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JWJPKguHCeoGtduHfGU5S/8MyB/A6y3I3oSqBblVl7d4PY53PI3z2QRXCi2/Olv0BO7WCRbN4HiPWc6mCDO6g9h3rLUVRApWdgqVIomTEIkB5zrS0qCjF7gb8jY70je4DIeiuLo5YxnMNOgBsbyJRYiqaVGJxHKhbtaPAoCoDnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=HFIiJdeB; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="HFIiJdeB"
Received: by mail.gandi.net (Postfix) with ESMTPSA id EA49F1C0009;
	Tue, 22 Oct 2024 09:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1729588896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oz7E9iWF4s9Z+25FJFmk9YARIYIBtPp1RNjhIdXmkMI=;
	b=HFIiJdeBaUeX7o7FsVa4GaqXgWMhL7V9RBIED9BON4wP4n182JxeQBSqXe41BF8giHRkN8
	WoBQ8QbeC4wzFT+HlRIQcJT3N/zeSTiV2s7ucL/fYKBOMdsraPPuz5DHkTWpMihOvNJCCo
	4pO4boatX4j7Wpo7sAbgupr2WQ14zrmmTQD/jzGn4TsAqJGJP/2hjZQ/VxL9IhSOBRuUSv
	QQFZvYyO/9Vk1j/6ZJfAHpfudbkj52yvYblIG6pqfpKTUpmhSftTYqrpPbwHz8OZd1qSJ7
	mrCqlqCBByVvIqq3LujNywop4SdW9+Oh2expVE5EsglTwl1MKsX9CyldVLIu8g==
Message-ID: <2c79be22-1157-41e4-9f3a-53443112ca9a@yoseli.org>
Date: Tue, 22 Oct 2024 11:21:34 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 1/2] m68k: Add tracirqs
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
 <20241021-add-m68k-tracing-support-v1-1-0883d704525b@yoseli.org>
 <20241022012809.1ef083cd@rorschach.local.home>
 <075d6720-a690-437c-a10f-e2746651e2a8@yoseli.org>
 <20241022043037.13efb239@rorschach.local.home>
Content-Language: en-US, fr
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <20241022043037.13efb239@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org

Hi Steve,

On 10/22/24 10:30, Steven Rostedt wrote:
> On Tue, 22 Oct 2024 07:42:10 +0200
> Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:
> 
>>> This part of the patch shouldn't be needed because those shoudl be
>>> called by irq_enter() and irq_exit(). Does this not work if you don't
>>> have these?
>>
>> Thanks for your quick review !
> 
> \o/
> 
>> Indeed, it works without those lines, so the patch is now a one-liner
>> :-). I will wait for the second part to be reviewed before sending v2.
> 
> I don't know enough about m68k to review that patch. Just incase you
> were expecting me to review it.

I was not really expecting you to review the m68k one no :-).
I think I have other issues which might have impact on ftrace too.
For instance, when I launch cyclictest I have a warning about HRTIMERS:
# cyclictest -p 99
WARN: stat /dev/cpu_dma_latency failed: No such file or directory
WARN: High resolution timers not available
policy: fifo: loadavg: 1.21 0.40 0.14 1/122 245

T: 0 (  245) P:99 I:1000 C:  11203 Min:     92 Act:  623 Avg:  775 Max: 
   3516

The latencies are quite high...

But regarding ftrace it seems that the trace is not able to give me more 
than a microsecond precision. I addded a few trace_printk() in a driver 
of mine and I get:
  irq/182-dspi-sl-112     [000] D....   277.160000: dspi_interrupt: 
Received 2 bytes
  irq/182-dspi-sl-112     [000] D....   277.160000: dspi_interrupt: 
Received 2 bytes
  irq/182-dspi-sl-112     [000] D....   277.163000: dspi_interrupt: 
dspi_interrupt
  irq/182-dspi-sl-112     [000] D....   277.163000: dspi_interrupt: TX 
FIFO overflow
  irq/182-dspi-sl-112     [000] D....   277.163000: dspi_interrupt: 
Restart FIFO

Do you have any clue ?

Thanks !
JM
