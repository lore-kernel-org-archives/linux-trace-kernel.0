Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3763C13EF
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Jul 2026 20:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783368677; cv=pass; b=MIe1GOPV5Rl2pTR7KWhl3GJpsEWe8UfBh0+tpONuGcgIr3glmhSMGpC3keG9KqEQQIZnXTuwvXv+lF4XW1FwxaMk0bA1+iCpCXaRhYFlRf631tiBetzVokPSfJJkHtIWqyf6GK3hftZNdjrVjXXZoSVIZyRySmcfTUC6zjS9gTw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783368677; c=relaxed/simple;
	bh=yMPcGqETb1sVOfA2EfkLEzhu+Qw3toGJG9+DCNHbzTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ulESfKeG4jBRiPMNp2T3tAg44hUqNFvrdzy641CeEWWhvJF1lFEIs+37XziYgGm4KLZWffpSNM6qDK0oAR29N97QQQ0K4c9bW/favElzCdDgSFU9m+H7nLefqRZ9ccbS76zpbs693GI6uPdiWmpXt5uF6z0+pcUC5SzZGIg1Jqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fLO/6Y6P; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fLO/6Y6P"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8111c0c7561so35167157b3.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Jul 2026 13:11:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783368675; cv=none;
        d=google.com; s=arc-20260327;
        b=rv7d6zE4+qq9aUPafivYL6tLQqtQb8cMcxf0T4HEys+i/LKL6fEkg2gCI2Yad9de0u
         5BlwIl4BanVHWNgJDVIdTzYjaTGyGCCfmxytjibdj4aduls3EJz65QWoBUORrh38sXEG
         FPG9ZGceyVomy2P8tA0RiPIhGr0u6uawQtFPXAPrhb5DrHZhoHrxEhdlKluXDVEQei6b
         DdNEr+Kjzk+bYfMbg/So+jcAd5h3LU+RNnR7fjNZpAK+6kqEPhtrDZpiJiVTnARk7Mew
         sh+xR5G4sv1XGsY6WY+wkTUfjy5+9A+x5lMytuwmQynH9fr+wkb6BvOQqjilHN3z26MY
         N9mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3zm66ESlbCDanOzCJkkaX9q4klvH1ip3CQSOWs/Z24c=;
        fh=sD4z9OOgv5rGVBA9Jxe71po4IoeazjhCOgKdbgxxbmI=;
        b=UobBVhtHzBdZkk27MnyU9/10w1t8q0INPGFA0UzxITG3/2lpAIpOkY9nA7h1FCtp6m
         hoGFZiZwvKGw8j1GFmWc363DDjj56eXehMKwKKtCLQWAHCFKrNn7wsCmmk6ODayIQQdS
         Y+C66q6uE4VVD3pCpb9G5cKbM6yHM7R4unXiqB51w7GkF/NnIwvyPrNS5cCW1ByOqyzP
         pYaDSpki0ktpTyOacD11Inxqusx4Ufqn1agp3fzz8fCzkhhGjqqqohnll0I6l8CJxhvB
         +uTaYd/3RH1gQNYgvJ6uxn/hsj3Zy26pO77j6haUqS2tKOFjOaDrOVIUqHVkgt9ZP3xf
         tmUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783368675; x=1783973475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3zm66ESlbCDanOzCJkkaX9q4klvH1ip3CQSOWs/Z24c=;
        b=fLO/6Y6PFNC6Xdy3DZdXfK8tE44uj9zm0TwmQv9rJUKkokvrQNtj85o9l4aqjtFXPh
         BNnYipZ6bEprgNfcCE8o3FQnmzU1NxuNCdQltwN7mXdMfk4tWVVphaTOvDWvmS0THEln
         5ccX6seH3gbkpNk20POVO8G0Ym6XRVI3HU5UZeYN/mzDJNbMBKAoYU5OAm9z01obr/fg
         BcMNSsaMiGQ84G12TQyS4nMX/pCePY/QA60KTzkjCeFpkff5kFWL9gZ1D8tivFvYyKzD
         hs7HsJTf6hO37Lja0r1WOkJvKgJnJlEKA2rEC6Tpy+4gsIXl8IYYClb93UPcdikBi4Cr
         HWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783368675; x=1783973475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3zm66ESlbCDanOzCJkkaX9q4klvH1ip3CQSOWs/Z24c=;
        b=sl85Ss4bR6ftHA89AqeT3BOvX0zJx9Rdk1iFXM20Xt0KChONw7J3Dz1Ylge5P/ZdlD
         naQ9KryCIJZYWy0cZWCTsL6jgsmV4I4Iu61mRdPQekcC5S19fODyvH+1ocUpd2nczDyV
         y5fV197XJ6OeNtDMNjRM202e2VZ4XAR9oNTqMhIc81qpbyhRADAZTxIIZJR2qvgDnGRC
         xuFHdHx6GpLk0TbiiGzQ590X3fzhxd4+jnG2mw4I5cAeWXFQdKEqLcLtXaA2YEHAIIPR
         ZUTFHz8vx5E6ySaCEB60P6AShR8TkqwbdWTEcFvyJSGioEXl4gHNoGyNpstLPBT8jW97
         l0iw==
X-Forwarded-Encrypted: i=1; AHgh+Rrzn5psiI1BNzJKHiHBpNZUto6akBXDPKQirrU0Y+N7ci+TvhW0TRhZuAkmRQ6M8afowwh9yV6NYWMBViANZEwjAhA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ2WYxj46RJr0M0oJ/Jhqbdf4YoP5AWb74C56ed2L/CEtr3S7P
	2WOhokqTDSFJv4OsEEr6slbfgSddQK7cD20bnkT1KQIwQ9FcbVBk653RH5EN8eGINHIyKcoq2fH
	h+RvI8AQAf8bLL2gSCEP/5qzzHL0RweA=
X-Gm-Gg: AfdE7cnfGGj10uGN2swuguJoCEVLgdut6ZHO9aRRukxd5G9ydodsID/TRMwHttbvKZF
	3eZZDTwOpzSemnhJjXQnssP2ShzNUUiIu/7/c0UC7OQOnVJ9zcAs2vkVoFyUoshrqBoas7tEEAX
	ULyw/JMJX5T6QMb14loz6RZaJkU/Q1T/jJCIFAjXJM5gARqqrZUfpWZnHSoBPDxKfER4AQJdxEd
	NacbpEonDMADhyeF02w1WE4s7ksGv2AMu30JvonSljz9QE7qZ3JsrilnsDoMIDmSRoeRFoDSxLW
	1/QpRHnetD1doatgs9d0g/Q7DQ==
X-Received: by 2002:a05:690c:4884:b0:80e:16fc:5bc with SMTP id
 00721157ae682-81be276ec1bmr15125827b3.35.1783368674678; Mon, 06 Jul 2026
 13:11:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618222743.538915-1-michael.bommarito@gmail.com>
 <tencent_89647CE40DC452B891C65C94D1B271DE8E07@qq.com> <20260624200535.GA132-beaub@linux.microsoft.com>
 <20260706160650.2791767d@gandalf.local.home>
In-Reply-To: <20260706160650.2791767d@gandalf.local.home>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Mon, 6 Jul 2026 16:11:03 -0400
X-Gm-Features: AVVi8CfITkA8qNrd0NsvAlpPNxypVSy_SkHP0qNijMyk9oK0DmBZjrSsOeUSyug
Message-ID: <CAJJ9bXzJpYRE-NjOjiArpuJWGnFXr+jq7ukbEEdEhK9YPCbYrQ@mail.gmail.com>
Subject: Re: [PATCH] tracing/user_events: fix use-after-free of enabler in user_event_mm_dup()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Beau Belgrave <beaub@linux.microsoft.com>, XIAO WU <xiaowu.417@qq.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 6, 2026 at 4:06=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
> I'm taking in the OP patch, but this looks like a separate issue.
>
> Any update on this?

Sorry, had gone fishing.  I'll have v2 in the next day or so

Thanks,
Mike
