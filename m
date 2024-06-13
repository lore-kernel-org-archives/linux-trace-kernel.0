Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB17A14A617;
	Thu, 13 Jun 2024 18:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718302815; cv=none; b=uWR6fGAhhQUNIuMt/UsuYC97beaSsUYXSZUhV5yDpoPmZzIT8iKudDMNEQJDD7r2+feX93Rcp0ywZ5w/S7j3h0ZOO9ta69shpIpepCQwBIY1i+0h2TI3jroYWFqpVDRDFKlyh3UCvBrxYPhwf21YEn6lzu05VN+0X5vTKQTg0aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718302815; c=relaxed/simple;
	bh=TOatw6k1CBHe6gpw+mH/HeqeppZsp3vmIJFGZFpVvXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sp0mWKY52Mt3lfOdVo9bsmFRABV1EMLuJk+pPyBCUNoj37YKxUX+VlRYPaTRrf6hMYjgJ21p3CtOdN8QdGDZm4j8wQihp92LlGiocMW6qh2HoVjj67ZrQZJJiG26azoCDhj9Rr26HhxPLMOpUQaK546hrYsxODkGjH21CK5PlQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=K5Tq4sbm; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="K5Tq4sbm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=MFcS3b+KeKQkV59PFBLNqWqobt/CiM0335GMv/JZlvo=; b=K5Tq4sbm0tlVf4ZuqWLDIzEa0C
	EzfP2Ai6ZiPZeNKXwoUeBMPn8vLVNc0eZDJz7ZSasFRD9iY86GSJehBQaVEaAWRF3vuGMvFnUWC0R
	7GaQdTKJC+7Smw7nMnofWsPx9oDV5Adw5wjU56kqvuQuUqy+XdQRgeFk8S0P3zHiQMZmWKXGxSODI
	kEDcFEWd/tgtbCNH1IvL1TzrViB03FvBLl1zwvcF88m5UFU4BldfYu4H5TPLHN6ThAWZ58OlUzFPS
	wx8/gNpCtJ5l7ZV7qdanx3T+BGxGDsBQ2FyypyozxYdJAikkJl/lp7RxnTBcNoFQ9epayhX5Kbp9g
	jc+O7m6w==;
Received: from [191.205.188.103] (helo=[192.168.1.60])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
	id 1sHp3K-002pj6-Bc; Thu, 13 Jun 2024 20:20:02 +0200
Message-ID: <6a6bd674-48ca-f7fc-d572-51e52e6899d9@igalia.com>
Date: Thu, 13 Jun 2024 15:19:50 -0300
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
To: Steven Rostedt <rostedt@goodmis.org>, Mike Rapoport <rppt@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
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
Content-Language: en-US
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20240613155527.591647061@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks Steve, re-tested in my VM and it's working fine.
Just a minor below...


On 13/06/2024 12:55, Steven Rostedt wrote:
> [...]
> + D. Using a region of memory reserved via ``reserve_mem`` command line
> +    parameter. The address and size will be defined by the ``reserve_mem``
> +    parameter. Note, that ``reserve_mem`` may not always allocate memory
> +    in the same location, and cannot be relied upon. Testing will need
> +    to be done, and it may not work on every machine, nor every kernel.
> +    Consider this a "best effort" approach. The ``reserve_mem`` option
> +    takes a size, alignment and name as arguments. The name is used
> +    to map the memory to a label that can be retrieved by ramoops.
> +
> +	reserver_mem=2M:4096:oops  ramoops.mem_name=oops
> +

Likely this could be fixed on merge, to avoid another version, but...

s/reserver_mem/reserve_mem


Cheers!
