Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A4F153814;
	Wed, 20 Nov 2024 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732121474; cv=none; b=Y/c6TAv9O+KBUE6TY5H8+frIP7RXt1YAMVfcT/4N3YmJdlI0p24W08024D5iIPLeEElne6uudrlvFMEo35ua/yzkIHFtbJFZesVuwKEkWDahfTh20WSQVcAVSoFquF8SSrBiTu+FK8eNRKaWBOv0i3AlkqPIoYJ40QXwdR5iCAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732121474; c=relaxed/simple;
	bh=FCp62Nk3R/z7mBK/KJriUMZ/kO6zaz8UQdOXrf4Pskk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UKUTIn/l0pbtrt/ZHi+1WkUVKHSfgx3I1fZhN75DorPUYjAbRkZHVBeyXvwyj48MNvP+u4DgKxNLFQyIggQZ/Wa064F1mocub0vHCdgoK4yNaGmgkygNkhQ3vNGRCS3wpsezL7TtEf8gwOsJ2veHnLvHzVQGCRhqHRMngZ/4mg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org; spf=none smtp.mailfrom=yoseli.org; dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b=WhPD/xyf; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yoseli.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=yoseli.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yoseli.org header.i=@yoseli.org header.b="WhPD/xyf"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1930F20008;
	Wed, 20 Nov 2024 16:51:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yoseli.org; s=gm1;
	t=1732121464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3FTjxfBZmWQS65GNRmIHMoS/Ljz1h55cLCa9PWWBBNM=;
	b=WhPD/xyfefmpMjmQi5CDiU8Zbm3LjvbpQUp4fbzCuPb4QXUyeeLJA0TSo482hwjRjrRDci
	/DaU+tQmhcYymoM7npAwTFS4Sr7F3rR5FgCncLQ1GzPCxF0lV60xhcpQhOdlMj8s3iqdd7
	5If9tOV1/yyqSeFPhWbIqKJE61UOpg0bghsIX5D+TDetUeYXvD/qmb6YAPbev41suTMHkS
	bGq7sjK2n95W0x6FANodsBxO0T/WVYenCK2vNLAXSyQPXk46pBBRkUBaHhI4s5PTsx9xOW
	JYnPWXZiztmNrYtWo49PrnKrSP2UvA925fflYzofzSYD+GWe1CJKAth4jJ8dOg==
Message-ID: <6da6dfe4-f5f7-4802-902e-47ec89364b35@yoseli.org>
Date: Wed, 20 Nov 2024 17:51:03 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] Add basic tracing support for m68k
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Geert Uytterhoeven
 <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>,
 Tomas Glozar <tglozar@redhat.com>
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
 <3a8f6faa-62c6-4d32-b544-3fb7c00730d7@yoseli.org>
 <20241115102554.29232d34@gandalf.local.home>
 <cbb67ee2-8b37-4a4d-b542-f89ddae90e94@yoseli.org>
 <20241115145502.631c9a2c@gandalf.local.home>
 <2c43288a-517d-4220-ad31-f84dda8c1805@yoseli.org>
 <20241118152057.13042840@gandalf.local.home>
 <22856ed6-b9d0-4206-b88d-4226534c8675@yoseli.org>
 <20241119102631.76363f2a@gandalf.local.home>
 <20241119112850.219834f5@gandalf.local.home>
 <e4456cb1-b1bc-453b-b3b5-3ee4f03995be@yoseli.org>
 <20241119131035.3c42a533@gandalf.local.home>
 <66e2b7cd-4a4f-4f60-9846-a14c476bd050@yoseli.org>
 <20241120103150.3442d658@gandalf.local.home>
 <2dc1cdfa-d33a-48b6-ab77-d04b06a3efe8@yoseli.org>
 <20241120114341.30ac73c6@gandalf.local.home>
Content-Language: en-US
From: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
In-Reply-To: <20241120114341.30ac73c6@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: jeanmichel.hautbois@yoseli.org



On 20/11/2024 17:43, Steven Rostedt wrote:
> On Wed, 20 Nov 2024 16:59:55 +0100
> Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:
> 
>>> And that way you will see what 'ptr' is before the crash. Or did you do
>>> that already?
>>
>> Yes, I did, sorry I thought it was in the previous dump :-(.
> 
> Can you see if this makes a difference?
> 
> Patch libtracefs:
> 
> diff --git a/src/tracefs-events.c b/src/tracefs-events.c
> index 77d1ba89b038..19ea3b3f8d36 100644
> --- a/src/tracefs-events.c
> +++ b/src/tracefs-events.c
> @@ -274,7 +274,7 @@ static int open_cpu_files(struct tracefs_instance *instance, cpu_set_t *cpus,
>   		if (snapshot)
>   			tcpu = tracefs_cpu_snapshot_open(instance, cpu, true);
>   		else
> -			tcpu = tracefs_cpu_open_mapped(instance, cpu, true);
> +			tcpu = tracefs_cpu_open(instance, cpu, true);
>   		if (!tcpu)
>   			goto error;
>   

Nope. Nice try :-) !

If you need me to add a few specific printfs I can run it.

JM
