Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7A51D5CDD;
	Fri,  4 Apr 2025 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743773459; cv=none; b=WJBwuYZuwQFV6W2dmKJyFVL3MGdWCmZw+WPOE/776TL5UaCoiG8SEZvfFwe54mlwKk2vHOJq38lvidgdyPd/8C6qJcCllI5zjku5Id52LHf5fPQavLRrikpsrR+wJ2l4OsdYy1VAZ6OHwNe9hyJQAIzYz0LBIZSWOee5j/N2guk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743773459; c=relaxed/simple;
	bh=KEheuGKDa3xDyxK8dtla1ri7UmskiUWGGO05j4SMl1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tnMhyIOjEguJKyM5N78isHD2FY8P3yLHLSmE+4invsMpk8aMbMufowrC6bqRvCX9IkPUaCA0qLof7TUqpsyDwBcbTRl/YnkiMWQzB6FlBbKbTePW2345fDc28dhFM375tBxyVfnXhzhchwdSjOyLXZht6WaA34YJ9hItnig8rKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K97qIKsF; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K97qIKsF"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7c542ffec37so183060385a.2;
        Fri, 04 Apr 2025 06:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743773455; x=1744378255; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KEheuGKDa3xDyxK8dtla1ri7UmskiUWGGO05j4SMl1w=;
        b=K97qIKsFDBC/2ciCDGq42auIfVfLjpw59R0Y5O2LVr8/l78p8+GZD1SuoiXMy0ce0h
         nojJWiKTW85yXrmygaKXG4F2xTcLuJaqxefxN0DkV1t6LwJZZ+Fvpe+R1kPgaJlxrKwF
         16TLT5UXTgXKsuFyr72+bCM7bdL7xWtA4KM/ds7g54vVTZGMfpxRBRzadZGy2Cq9YoKI
         xhE/FGKcJ4y/a+GR098nfqH3bpQECnyJ+jOksa89MmUG8oKKEpXip5I23HQdfTIuzSAj
         WDxM7sDcs9Qv+0QMgyfuEkaKrMMj6w3oFTlZ8CsZUPUQThKW5SBJbJMtSnskjHa5nymn
         CSRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743773455; x=1744378255;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KEheuGKDa3xDyxK8dtla1ri7UmskiUWGGO05j4SMl1w=;
        b=PgSjmagt6dAs50yYhC+fR3WASRxyQtYM66vxgwXivy8pHQ1FBrv4X1KwpH3DRAaW29
         rLpHE0B5JAImv9Wrsa0VnIbiUJxMUx05hhT3W+va3kuU7BBYE9xhqPvM6GppD1EZdNZO
         8ZvZiWA9tzQ7zDtro2B0fQUtphmzJV54EqRdHvYgH7dgYCmthlDSE/O0Fz1hKeyuOGO6
         Q+p3iRNB5+uBRTyoSUzI7ZRxEwZSg+ODvzoqesIL4uuFsyU9bzcKTPxynkhch5hdjNWw
         1X2+/uQwhET8dDRiIe31j4iHaixNNcsKSapb5P+uDAAMzZ8SI/DoWp88TVmKnv6Qy83E
         RcSg==
X-Forwarded-Encrypted: i=1; AJvYcCVXw2ZtRCcFUXUti5a298/Cp0a/414EfbPTC+IvvyCqMKp+w44RsJScMYpTJu8mPK6ow2ajGHrjLPJ5KJk=@vger.kernel.org, AJvYcCXaQE++qxj9HSBDSBhQCy+yQrPYYCzFrTy7IrKdbdir1mRdldi/R3XYEzfNfdypBKkN1shs26zmNBQve0AsVXCOcFEU@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2D0Km+p2qHR/NIelisIPsZIWGqOa8azHr2Qc7/bKRR3PEu63z
	lkaejmH4wcIvTYVBjGKsoLFxAwNZph/2ffqg2dJVoHFnPJXBOj9EVa43vSjZnw1sx7wNgRH92Bu
	HbzbJ4RZzHEi92dqxPDRxt2Y8wzM=
X-Gm-Gg: ASbGnctctBgohY4tOnt5iRCawhK8upSVMUHa3HZuwU6dkRqgJhRiiVir+gH+NAVklNP
	se2vwssiuTAjdxapIP0uFxJG58KPFRYv2fO02P4jYHW9ypVEMp2oN5OeUiBmnHQMGKLoZe/Klwr
	ZaeABoiuTu5gKq26SnYvorYRoSwu3k3m2xzoD1895PcPA+eSljbFZ84x4=
X-Google-Smtp-Source: AGHT+IG74nCo6Nd7B0/H04vVPUhu27C+aSVBiz8MSHiHl9a70VyfzXJteEMrg4awfqIW8agEuRHW1vhfqJGHTki99cs=
X-Received: by 2002:a05:620a:c4a:b0:7c5:4949:23ea with SMTP id
 af79cd13be357-7c774df5ea8mr378073285a.47.1743773455589; Fri, 04 Apr 2025
 06:30:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250403191342.1244863-1-devaanshk840@gmail.com>
 <20250403153651.1188135b@gandalf.local.home> <CA+RTe_gHo3U-tWM9MA4CMgxM13=biqkqnAbuS5Yuidrono1bvw@mail.gmail.com>
 <2e5aae65-316a-48c1-b293-041bfbd1ed80@efficios.com>
In-Reply-To: <2e5aae65-316a-48c1-b293-041bfbd1ed80@efficios.com>
From: Devaansh Kumar <devaanshk840@gmail.com>
Date: Fri, 4 Apr 2025 19:00:44 +0530
X-Gm-Features: ATxdqUEIAeQDGiq2YwZYgVB7Lp4MkBRHfwXEjEocb6xeBIEiJbPMpiIU8boV8DE
Message-ID: <CA+RTe_j71dE2us0mjPfyEfThKDJ_xUQ-SwFr2Ykx2AoT8yFJBg@mail.gmail.com>
Subject: Re: [PATCH] tracing: Replace deprecated strncpy() with memcpy() for stack_trace_filter_buf
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Apr 2025 at 18:24, Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
> It's not only about the destination, but also about the source length.
>
> AFAIU, turning a strncpy into a memcpy here will overflow reading the
> input @str if the input string is smaller than
> sizeof(stack_trace_filter_buf) + len.
>
> This can trigger page faults or make KASAN unhappy.

I see. I will create a new patch to fix this then
