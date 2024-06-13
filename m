Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DA6139CFE;
	Thu, 13 Jun 2024 18:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718304708; cv=none; b=CIYD3dR2Qmxwb2SM6ovINvcd5ZKpDsJQxgY9wQ/j9tD4L3tODouxDdLt6Bu03lGAtOT1jul/JuHOgVDrM8uKrNFK7VuJkaSJpPW8jBuPV7O6J5bcOU//syuiP4EwD4Ox6PzqRRSOYmMq+4d3BcIlWKOEgpaDccNLB9xYVcBd5+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718304708; c=relaxed/simple;
	bh=iV4q/X0Wj6UHGCAGLqeS48rT8zJY+mCSDmYajJv0QZM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ft6LY3JUsNnEGrEOe525Ep/35PUUz9SMtHrIg9voXALGVHia1JIS4rUiRTS59m9Jj0naRrTIJ7ncWgQTr5+e+4KB02u2OoTlI399/5hdO6L+VZ3DoW5rbmSsfXlufeU4wD9cEB1h9p8vnxoZVpiynwWCCGvg/P1jrZlAEBc03Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=T9QPArPz; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="T9QPArPz"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=9HN5Q9m3aml9BDWCtbf5XAXVRqLbIQ29IsCzgD1YK88=; b=T9QPArPzVGnD7tA9lxmswDYhaG
	wPXm01yGP4vRBLtzkEUoyEmxb9ADjsu0ud+8cU6NUJarVry86LAS+wwRm8xOJ/5E+miXe5hnNcTes
	386fiCZjvRoOLfX9Pr3r/+EqJRdlBb7Ag+muNAfmJHJz5+O63ScJ1a+OHHMj4WvvOxKhsWkbBGslB
	jV0Kd3OUFl2ZezEQuB814vQ1FQbBxWl8Q5H3SDg8e4ke+gIp8VK7eypVNDc6iFhfIr7TyLvFVPuu6
	YgEgfqFVaYYCn1FI5Z8NyA6i4WdwLgHAvW9jYfuBW4BL5SSSvDpObf9QTEOWEMSohbAZAaVZAyXFT
	sANcU5YA==;
Received: from [191.205.188.103] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sHpXs-002qHg-Lq; Thu, 13 Jun 2024 20:51:36 +0200
Message-ID: <3c6f4c1c-6dca-aa82-341f-758c9c3d4ffa@igalia.com>
Date: Thu, 13 Jun 2024 15:51:25 -0300
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v6 2/2] pstore/ramoops: Add ramoops.mem_name= command line
 option
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mike Rapoport <rppt@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 suleiman@google.com, Thomas Gleixner <tglx@linutronix.de>,
 Vineeth Pillai <vineeth@bitbyteword.org>,
 Youssef Esmat <youssefesmat@google.com>,
 Beau Belgrave <beaub@linux.microsoft.com>, Alexander Graf <graf@amazon.com>,
 Baoquan He <bhe@redhat.com>, Borislav Petkov <bp@alien8.de>,
 "Paul E. McKenney" <paulmck@kernel.org>, David Howells <dhowells@redhat.com>
References: <20240613155506.811013916@goodmis.org>
 <20240613155527.591647061@goodmis.org>
 <6a6bd674-48ca-f7fc-d572-51e52e6899d9@igalia.com>
 <20240613144248.2251b189@rorschach.local.home>
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20240613144248.2251b189@rorschach.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/06/2024 15:42, Steven Rostedt wrote:
> On Thu, 13 Jun 2024 15:19:50 -0300
> "Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:
> 
>>> +
>>> +	reserver_mem=2M:4096:oops  ramoops.mem_name=oops
>>> +  
>>
>> Likely this could be fixed on merge, to avoid another version, but...
>>
>> s/reserver_mem/reserve_mem
> 
> That 'r' is my nemesis! Almost every time I type "reserve" I write it
> as "reserver" and have to go back and delete it. :-p

LOL, I thought the same! And I even wondered if you're not a vim user
that makes use of 'r' for replacing text and double typed that - I do
that all the time, with r and i.

Anyway, thanks for fixing that.
Cheers!
