Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937517;
	b=OKRYhj6awTgVFmiYoqNZxpMqEbov7W4o0QFDurhfv5ac9kjLTaut6LONHjnzBuAODjUS
	 JUVRlbAdvxbxaMCW34yvteceJOh1UQJZUttMeLvMn11w52JoaUP+lAvMzw0Z3EHNTmgAB
	 1PlA8OfrcV92XTX3ofUUHFBSvH70/XiM6EoN/YqgF8nk3uFySFc2J5He1PdyGyiUnHs0Q
	 A8jqqqVWUesUzkLMIXoj9Hu07VSJ1swn4hJmm6/aW0BkUSAgCkCglh70oOziV7cMrPPXS
	 KUryesbDG0h0HYxk3KnjktfTQgrjRV0XHkIb9sJju0PfbCf1jbMHA53bhZtVdCwFe2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937517;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=yKaMzWXUwfQ9LI7TbUbNbChNZvqrpOopz9IXAJacmMA=;
	b=ljp7tu2IKlmDFDKFvL/2Ni7vDhcSfrYOPy74/YQBIX4rCvKzJLnm1xGfqbBn98u2BSjd
	 h/LGIESZ4nIffqPE2bxjMNrEVvp8YQqmK34h2z2QW5Q/Utf88usfB6ZlLqDj9NVHJnTVo
	 ZfPM27UFTnd3oGiQXF4VbzfKResHob/HsR36RFqro+pAus3oAhscDuABjAkJmOd73/XQa
	 Zqvpr3mtLGzechlD4Yz8OHvEowmAjV6sZUMjkiPPjyIpQ/SBhB0zhZYYgzClxo/yTYlxI
	 P9x0BI8djXwoAKf79N0dxs5hLwOyuWWAe2M4hCwMpS1OAljCMO7WlLSX9uls6rSutkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=f3Xcnf2M;
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8D3606A330
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 17:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B8D3606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=f3Xcnf2M
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1b3acec6677so117088c88.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 09:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1794937516; x=1795542316; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yKaMzWXUwfQ9LI7TbUbNbChNZvqrpOopz9IXAJacmMA=;
        b=f3Xcnf2MvPzC7mGFrA2/x+siBtJv3kdjLI9oPMWZg5WpGdoXYKIhlnwwYE1EqRarX9
         ojz3PQYDxE8RG97NKJf22aBzjVRUCwouSwDuyn9szPZTIzs2HLfPhmutHrhJiFqRJ7uB
         hund8sU1v9zOz8m40T0BeB9RXAU73L4WDfLXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937516; x=1795542316;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yKaMzWXUwfQ9LI7TbUbNbChNZvqrpOopz9IXAJacmMA=;
        b=h1WbMjd6/XeowAVfU7EiiFhRyKVJ/BeI1VU51Cs2a9u2cQDbFz0jlwznPytf7t99Ph
         4l/S894z4CzTuVg2CPbUbE9Hxr7Y+DS7GmhxJXuc0rF3TKs9+SBmf0xy1JoRFRLBw/sn
         BmRW2rm5tObhHCg/jv35VHaFwyPEmRJ5Jgx4wsXZfyo4h2AIhYt1Vpek0vx8TyQAMwfG
         +fyNfE3lYBi9lWtF5/UJrHz4jgmEXDzFE37y2VszyUdT1Dfbn8ThI1jEBf+tTXdAMWg7
         2P8629wD7BKUN3gJcUomgVqSZDmSG2wiwr89HrQrquJyWyuR3ul/xANBdFxul45o8Vna
         JiQg==
X-Forwarded-Encrypted: i=1; AL+hErGVATUNG8QI07AXKtbV0JD7iIRFjBMgsmRCFJxx/2IVjZ8JDrdJkxJZPjtr40WFRoIfnKZp5cgwO6nvDTuMHBKNnMg=@vger.kernel.org
X-Gm-Message-State: APuU4Z/upKZuMJ8nTYIa1ILlL9dTLuyvzTxHyZ8A/LurdfkUaaSAmRbH
	/4fT5hZ6Ump2FWBsVzq9ebDttLSSQm8xNbv3Je3WHUPXLTbXX6lvWWBGuKZG5A872A==
X-Gm-Gg: AYBFou1+UNeQssbWPmPS7iCjPqw06R77n1g/vwuaBAZ6AuOxtyYaJBmXf3jEQ9uoWjZ
	yHFH5iohEIPcz/mthYwq8l6e67udotXjZjFBZBlzllzOAo7X7CMco9wXp7vic1zJ7mUdmMBD774
	pWvvOsPcNPNF3pSfplNaBZWflGkcqUhLDPkv5lHeH6OJqdr/V4oruolHz/Cok3yMQWkH5+Boetm
	2TdW/8PiWf9t9eVzR/LyR+f/OkIdzHd2v9n0swgNJSQNKoKN2+1/5TwuOxjtxF1UYIRPbGKvxfg
	tZ+CL0SFmPp16Iq+njqPb0GmliElBDHP2ewRzFjd/wxX2j8Y8e8zYlo4pprOoZW1iWSCuXlKiQI
	QEBpzhI7o6xe1lBUPbt57tXTKyqpR8bDB/NYVbWHy717KZTmPIsOP8E+v296KOGEA/yBUxonfwT
	xWzgkmTzjZwSY+ASSkm/14UTui2yIR76Hqijg0UyP2hRYryZ6Ue5hm2IaofEH+DpQYSkeofEg/I
	u0j2hdNm4B+DwID8BeLp6i0BtkEQGaZwLZnIH5NMEBFofZCLHJO1tc9kHOT9/U3HwR/2N4Z8oMh
	ZZ+Fj7xPsv8ZcgytDl+VwUp5FMS/9w0T6kP3kgcTJO5dDEf0swWlZnZS6wqjXZsIddZw4PQ0yZJ
	3eCP/8v16/newdw==
X-Received: by 2002:a05:7022:f106:b0:1aa:47e7:97e3 with SMTP id a92af1059eb24-1b543d09a91mr189552c88.15.1794937516309;
        Tue, 17 Nov 2026 09:45:16 -0800 (PST)
Received: from localhost ([2a00:79e0:2e7c:8:d92d:531b:8d97:bf51])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b524049e0asm22060282c88.4.2026.11.17.09.45.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Nov 2026 09:45:15 -0800 (PST)
Date: Tue, 17 Nov 2026 09:45:13 -0800
From: Brian Norris <briannorris@chromium.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] tracing: 'select' GENERIC_TRACER, not 'depends'
Message-ID: <avySqRwpInSfLIgK@google.com>
References: <20261116144652.1.Iecb63200dd245f62032a3b1f60ae78cc48868094@changeid>
 <20261117085317.4ae87046@gandalf.local.home>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261117085317.4ae87046@gandalf.local.home>

On Tue, Nov 17, 2026 at 08:53:17AM -0500, Steven Rostedt wrote:
> On Mon, 16 Nov 2026 14:46:53 -0800
> Brian Norris <briannorris@chromium.org> wrote:
> 
> > GENERIC_TRACER is not a user-selectable symbol, so it's impossible to
> > enable FTRACE_STARTUP_TEST unless one also enables some other symbol
> > that 'selects' GENERIC_TRACER for us.
> 
> I believe that was the way it was intended. The selftests are to test the
> things that select GENERIC_TRACER. Why would we enable tests for something
> that isn't enabled?

You may have discovered in your other reply, but these tests are
applicable to code used by EVENT_TRACING, which can be enabled without
GENERIC_TRACER.

But I do see how this still might not be exactly the right choice,
especially given some of sashiko's comments.

Brian
