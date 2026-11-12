Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794475535;
	b=5GeINLvVf3pNcyUZ30W4y86tpcWC22XrPoB+qNIHSThtpJa+r3GGmHsh/HwN/1M8m18N
	 WFZZmXS4hjL9EkMGioaQukCXPSgqzRr6BrINosOPTh/Rgxj1+y2KttJbcM+8uZKf4gvY4
	 qjcUVolBhB07tVK4VBNh0XteRpU5n6OfrGNrJSgbIDMkKvM92X9MPa2zXhxWSrUmjpkLH
	 ZRmo/KEFDILJqyha0cysDFfOQ8OjVySzbomoyFfiZrFcOXu3pe9gIV9ISzjBL0mVwhQad
	 HOfykKwSQlEWr8SVXXv4YFtZf4bMvbvSzblGZci9TRQehU91J1iOlrZ1H1xR1o21FBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794475535;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Rspamd-Server:X-Rspamd-Queue-Id:
	 X-Stat-Signature:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=TChqlxgvxyj/oh1Lld7CEgRxX8/6eci9KR66ZAyb5Kk=;
	b=lJZzYvMRsI2FcVU6aPPC913FEIA/Zze25rk3+8x0qusj0J88GttvvMAesqdBE31u9a4d
	 Y0KS+hXf7TaMYBWtkoQrPzmsfdIApfOfBBMqvwHyxsuMQHGFWS/h3yfrYHjsbYOTgmhmH
	 9Cu3IGEPAiZoDZwZY2BppzxY7SuuZ7wgKxtkBq8it81wOU05oowtC6BP3A6w0JCcOml3u
	 GxiEAgnQghykL23u1bvl94q418JqFDNd3yQ3fwkrfu4v1Nb0mwCE6ddKHu638WURREtIS
	 Yi4pX5msEF+tq8ytDkHfV8Mpbm+g/WADG5Uf+j11Rb/61bMKdWljhNQenMjnKTo7now==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=ErQTPuJZ;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFCC606A323;
	Thu, 12 Nov 2026 09:25:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CFCC606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=ErQTPuJZ
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id A85981604A1;
	Thu, 12 Nov 2026 09:25:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 6486120032;
	Thu, 12 Nov 2026 09:25:22 +0000 (UTC)
Date: Thu, 12 Nov 2026 04:25:06 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jeff Barnes <jeffbarnes@linux.microsoft.com>
Cc: "mhiramat@kernel.org" <mhiramat@kernel.org>, "shuah@kernel.org"
 <shuah@kernel.org>, "beaub@linux.microsoft.com"
 <beaub@linux.microsoft.com>, "mathieu.desnoyers@efficios.com"
 <mathieu.desnoyers@efficios.com>, "linux-trace-kernel@vger.kernel.org"
 <linux-trace-kernel@vger.kernel.org>, "linux-kselftest@vger.kernel.org"
 <linux-kselftest@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/3] tracing/user_events: Share state with existing
 threads
Message-ID: <20261112042506.0fca0524@fedora>
In-Reply-To: <40C83F97-D53F-4050-9CE4-19449912FB20@getmailspring.com>
References: <20261019103957.69759ee3@gandalf.local.home>
	<40C83F97-D53F-4050-9CE4-19449912FB20@getmailspring.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
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
X-Rspamd-Queue-Id: 6486120032
X-Stat-Signature: jow8xa7w71ereiwss7xhb9afire7wobj
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+wyEA/6qs15cbEwMshE+EHhJIrhG577H4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=TChqlxgvxyj/oh1Lld7CEgRxX8/6eci9KR66ZAyb5Kk=; b=ErQTPuJZgpc0/aspmIiC9J7VR3R84yBQrxWvNBTkAQptb4flOQz6l3UY1wawXhBg38JY0K4XUR3Lduq2isHioMUc/tGaPgVr5tkrE+TB//oah+2iP0Hah5ehJKQ+my6mAH/UB+RmOwPz4baGLrW0YTwvT9r2tdAWsmBXbxTV5yg=
X-HE-Tag: 1794475522-153039
X-HE-Meta: U2FsdGVkX19xrPjEKLEELVikxxzKhCkvoJHJwZQMyLGKIU/POjt95rFi9ozkmWpYFDdzLDG2U2MVFuvYK4gnt4944h8HczwIUDrPTfLeQSyY3FVJhqpefE2HkBl2lZHIzDhSqMd5uxgb7w5Vqi9umgCnpTcD/6ngM8rO5lPl9fxft1dUoYs+mgbiSTpKUTQsIkKv+DBrZLb4z8RLqhgwctZWpv4w3vK1ecV+qTzp0vRopuDMZ4NQOK/0nMKvmdiMNb6YytQa6IsCenXRKWdMK6/nn+wftLc3lpFAthC9+CSKUUjsYw2UcXYxQBf1BFmZ1DqanLMAWXq3iSuEsBcB7bl4J0tgDbMw

On Tue, 10 Nov 2026 17:50:03 -0500
Jeff Barnes <jeffbarnes@linux.microsoft.com> wrote:

> Hi Steve, Beau,
> 
> Gentle ping on this v2 series. I don't have any outstanding changes to
> make at this point.
> Just to clarify, this is a separate patch from the Fail fork one.
> Please let me know if anything further is needed from my side. 
> 

Hi Jeff,

I'm currently traveling back home and will be taking the rest of the
week off. My backlog is a bit behind and I'm trying to get through
them. I do have a 4 hour layover, and I expect to work on triaging
patches. Hopefully I can get to yours, otherwise, it may have to wait
until next week.

-- Steve
