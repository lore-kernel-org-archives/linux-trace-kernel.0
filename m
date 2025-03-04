Received: from mail-lf1-f99.google.com (mail-lf1-f99.google.com [209.85.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617121DED79
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Mar 2025 03:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741057752; cv=none; b=I9w9C2XPMEjXSS6YKh6W0O3mI7SERzRx5IcUytB3UasPaNaM44yvqci6aK7GNdLvDbHqx6+hsCaciAlBQA6/yMdUcSpsRwbj0paUGfRVrxcxLlOTHADFMYYYWryNPFiucRXN7tHK/G93tkHMG+OcSFB/RKt/Pr+G4tVwcv44/p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741057752; c=relaxed/simple;
	bh=XAX5kNvACP91UXNcdnDTgumV4d/6JMem6vwatakdEKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvlwNa1Ygm/8E3nIYN1NKAHIWIWBSMFbuZNOvXoZeR1Oi2oo/K6OF+StCP8n3s9ODT3leHZYPCziT7z/WBM2OemjMvLpLacDi/Q3E6/fCYfAbbgyq095UeaRtAxg2h4eu/0IF5l9WrwXyDsS5O3Lx+5OoAIQcVju5zJ6KOaUr8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Pk7gBwhc; arc=none smtp.client-ip=209.85.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Pk7gBwhc"
Received: by mail-lf1-f99.google.com with SMTP id 2adb3069b0e04-548409cd2a8so5357023e87.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 03 Mar 2025 19:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1741057748; x=1741662548; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/HaTgp9n3x/1hhkTDyIg3nxbnnDs0fCQyAsV1iOMog4=;
        b=Pk7gBwhcPx3mgF5r4tZAFVYbQvYWoMdodmlCjF3o//59/x92f9uKUsXyVfF4AKi29n
         +Ml5a5uqdoJZos8oi2aJy/JrqNzl/K/7sH/1G6XU7cwlm9yvzcIvsE68jyQVVuMv0JBp
         lgVC8yPXTwEW276ZLZlXyulNRiWZcRSo4jq94OkClhV29LcbbHhQw7vaoHhbSWRGy0A+
         mcTc+ViLQ0IUtHYc3atWkjn4R7sPb3wYHgJnKYRNgarakjX6ZHzh2d97THf9GGA/9J8y
         z/+cXRnbzDwfte0aKGs7EdK8hliNDNPpQhFfLggBkenjP+Z1PD4zH9ieznhye7Z4wW7g
         CKsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741057748; x=1741662548;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/HaTgp9n3x/1hhkTDyIg3nxbnnDs0fCQyAsV1iOMog4=;
        b=BqaHBkZsNEKcMZU+6HkHFcz3fkaKgTBV9VNzbpt1GkBOVe2vvr1+OelbwjBCb845eB
         Re9OdAXjKwuQJv5eiKd/jtmAyro9oV/iKMLpXeFbGuMqeiG3WmS4BLK6eap5JQFWAlRy
         Yy9QLAwXDU7pXybyCNanTAwPsg3Hx1CXmfnOfrRYDro+vrh8slBMLH3EhRhemwcSDuXR
         D0ovd35NVKEEk6VGdHR8pR8ErX8Ys75FpPa7PQngOR/qx626BhYBOusGpnAG+BSzIurc
         EsTLty0qmTg7NAw628EXheis9FfageRtGrR0TJi04wJLE9dv1ou27YqBaHL++OlQoHB1
         6nJg==
X-Gm-Message-State: AOJu0YzelsDTU9gI+ncXRFdhLCihjtwrEnG6++fWn5vgOs2DGAN/O35R
	PswQKzQ3/heAyHcewpy3Mo7vKUxjMqUBa6zSNI9r6A88uUM98rnJxh9gMNuSuU5414Dp6vQlFLb
	Bif5VNB5BYwtkkZcj0w6usxy06xVU0/XP
X-Gm-Gg: ASbGnctPRB8cZcYYqCr5qTspzxsgTqIQ8tXLNIuWg1h3rpdVPlfnlYH/rnixdIMb6P2
	wstNSj1lZledgfaZDRjrTtMfVbC4KwJjbC3aLQZj0zbX2RaHzVhzD12gKWPQmul0ru1FyNZAPdD
	J8pw8JD0EZtaqNZwZlKerIEdcDMnuMJ5VD4VBcWF5x2M12VGfLWnBRejVPpA5lS2ANzVHUFuuIh
	Cln6SPLeeGbC3ptSPB5h3YOgufgIxDCtPht1K0T8VPNTDARwaj+PoQ2UKYTLj9XOAQfNbQrqE/M
	pEW0FrknCy4l1YJiq9FaoSi4MLTimH29GZTkBAjsWcoV6vHTrQ==
X-Google-Smtp-Source: AGHT+IGf/IY6HezRQ43QtfLfekiv+xOizzvReIxLMI0ZMJ368PWxhP18LT82B+4hWSuhlPa4SQcohHFLjjGg
X-Received: by 2002:a05:6512:318e:b0:549:38d5:8858 with SMTP id 2adb3069b0e04-5494c124ab1mr5388036e87.20.1741057748190;
        Mon, 03 Mar 2025 19:09:08 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 2adb3069b0e04-5496a687c55sm132162e87.122.2025.03.03.19.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 19:09:08 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [IPv6:2620:125:9007:640:7:70:36:0])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 3020A3400C1;
	Mon,  3 Mar 2025 20:09:06 -0700 (MST)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 45E45E435AF; Mon,  3 Mar 2025 20:09:06 -0700 (MST)
Date: Mon, 3 Mar 2025 20:09:06 -0700
From: Uday Shankar <ushankar@purestorage.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Cc: linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 0/2] kbuild: rpm-pkg: improve debuggability
Message-ID: <Z8Zu0p2vCAfwXa/L@dev-ushankar.dev.purestorage.com>
References: <20250210-debuginfo-v1-0-368feb58292a@purestorage.com>
 <Z7Pv+hD3AOS/ymFI@dev-ushankar.dev.purestorage.com>
 <Z7zJ5EjIFLbz9C3I@dev-ushankar.dev.purestorage.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7zJ5EjIFLbz9C3I@dev-ushankar.dev.purestorage.com>

On Mon, Feb 24, 2025 at 12:35:00PM -0700, Uday Shankar wrote:
> On Mon, Feb 17, 2025 at 07:27:06PM -0700, Uday Shankar wrote:
> > ping
> 
> ping again

ping again again. Can someone please take a look at this and/or let me
know if I'm missing any recipients or if I'm expecting feedback too
soon?

