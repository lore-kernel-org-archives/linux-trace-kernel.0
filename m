Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4106220696
	for <linux-trace-kernel@vger.kernel.org>; Thu,  1 May 2025 18:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746123191; cv=none; b=GdA9npxcY1qmfrN+4FavNqttY6oJvX8W99ByuO97KCVvSDrM/3tUnevYeV9d8McBipy74E/i9lKzbUZ2Avkp31B3a3UX9RVJ7Ghi7DX+0HZsjj3MWd22wX+3hFvJ2YCSuH1jdVq7CJ2vB5pMdTDeXFtI/JDWAPzRrW3BVU0AuTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746123191; c=relaxed/simple;
	bh=orKMMdq9gN1Uy0eUdHFXvJY2/aFW9UG8f5Jw9EztR+0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KROmSJ1OL9AlUCgjM7kxhubPvPjYTO4OIBFa7AB8aX3Le5eaGgr9CrhxoIAJQLOYwDcAvZaWGNR5szmDzCbOkMFdaiLRYeaOReuQlPEvZN6ESuifzhycvobTUrpi95OoTKo6jh3OxeCCg4Nfa07nvDAGms3UTpZvaFqrAxpK/kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ddy/BXe7; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ddy/BXe7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1746123188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=orKMMdq9gN1Uy0eUdHFXvJY2/aFW9UG8f5Jw9EztR+0=;
	b=ddy/BXe7Q0F2HZULdS07iol9VzmmVq4pXqoKxmI0FH3uOKtlzX8fUwY6F5U4Rp7pLlfVm0
	KViZzg5EwEzULToeo+iN0pSUCRIVEH9LgUjbRX+05Fw+B5AAOTFpxuBxS6C9oJJohcGumC
	H0aVmJac6CnY9RxS64s1sDxVLuPgFb0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-b-b6jZRqPxCn1MFTplBpMA-1; Thu, 01 May 2025 14:13:05 -0400
X-MC-Unique: b-b6jZRqPxCn1MFTplBpMA-1
X-Mimecast-MFC-AGG-ID: b-b6jZRqPxCn1MFTplBpMA_1746123184
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5e68e9d9270so989722a12.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 01 May 2025 11:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746123184; x=1746727984;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=orKMMdq9gN1Uy0eUdHFXvJY2/aFW9UG8f5Jw9EztR+0=;
        b=Pef/vvkoDEFJRZZe0qxeEubFdIZk3z4+s7DPFVaQ6eSQifxnFF627NiBjmAMkQ6taq
         VyAw1evVHe5Fy+wI5DYc5XOrd7HjixD5cb1+Nar8C6ds8mt0wkcrfl3fdPoiBLxDHlUN
         jL1MA059iKgn/iRhp33Tok0aeNfMqO2uhndJaLdb0ifWhX+4GJliBDJSx8jzCSCTuEuO
         C4zT3q2SbI/kE/Jf5H0XqMLYEC85IjbPsB59qqlOjHQYVj50r41dNkc/unzW+GVh/TTj
         D1ujkEJgpnqH5eYuM556hxdzW0HsnfGmLvbpb7GV5JT8V5lOsvTCZs6wfTKg3H79Hq2Y
         i2FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQNVRi+JxtCjraAHQ2zmuzV09NUsd2AR5LZdlxFBqgvIJG+EiOQcFF3DZNVrxP+lEUr9nkA+iJ54i/9IH7vOTA5MA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf2FOkq0zrZ9QcRdNABg7H/1xlY8XT7AwY5h3Y4sHunDmLTHNB
	3q2pDz7+uwMsv4aB/VzOdSbSG1+YeQ7HtF47Zx6ZmVTTER6kGK3FevQcuIzVjfTz/5d+8z3SFax
	qgrQzVxYf6gt6LH6lehXljCHsEJ0pvyJeIAuntEOZ9ane71dmnQv4Iz1O1ZTnlYU2bByHyQvw+0
	JsVdWSSt0Q5D3s5jxgVUoDfLAZqUBrHMLFUN1YyRRoWy8EXlRIZuJpivY=
X-Gm-Gg: ASbGncsZiKlIQmA8rjo4u7Uy/Usw2V0oF+kFthfHx///VizRVDnJxLAd4ajfvnthKrl
	LJ1xah5zfSmmI91nzKl4hzyfBJ6d5L1n3rRrXhqf862QiDUaPZAnUHr5oRfnVCvsp6qh7D1P+i8
	2m/ycz/fDy9buAW5RjWZoy06eg5Yw=
X-Received: by 2002:a05:6402:2712:b0:5f7:2893:a6a4 with SMTP id 4fb4d7f45d1cf-5f9193c8ceemr3025572a12.13.1746123183795;
        Thu, 01 May 2025 11:13:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzw1qAMlPTeCyAI2DAnaT/0znUw7Y0kh1s/V5jH+CzIvUHnnt20FZtg5X6HDdIHPTx/IhQPG4wRtra2vetY2I=
X-Received: by 2002:a05:6402:2712:b0:5f7:2893:a6a4 with SMTP id
 4fb4d7f45d1cf-5f9193c8ceemr3025554a12.13.1746123183440; Thu, 01 May 2025
 11:13:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127170251.744751-1-costa.shul@redhat.com>
 <20250227200623.60f20571@gandalf.local.home> <CAP4=nvQXaFmemBeW8U3U9zTMK0gVYvp23gfq_6ALsBJPTXt9Uw@mail.gmail.com>
 <20250303150351.28007ad1@gandalf.local.home> <CAP4=nvQ9pXYtihL7HTTRK=EzUEubtWbxDr78JswksSo-wa7zYw@mail.gmail.com>
 <CAP4=nvTCVLa5MzBbJVz=S_ZiDoJ2hY-8fM+uRnGgumi0sFivWA@mail.gmail.com>
 <20250304121053.06b84874@gandalf.local.home> <20250501104251.46c2e1fb@gandalf.local.home>
In-Reply-To: <20250501104251.46c2e1fb@gandalf.local.home>
From: Costa Shulyupin <costa.shul@redhat.com>
Date: Thu, 1 May 2025 21:12:27 +0300
X-Gm-Features: ATxdqUF1UicCo53Lzxl87-4gQodTQGBOAsSCzXPl1dl8uCilZuvNe0SaqkbpGhw
Message-ID: <CADDUTFzQuwVCXO=BDhx8pXLo3Z-3sQMfw1-wHtB95i4wWuuv=Q@mail.gmail.com>
Subject: Re: [PATCH v1] rtla: Save trace when option `--trace` is specified
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Tomas Glozar <tglozar@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QT2k4WT3D0ZAqmVogH9Uk1xMZdjA-MEsgiaXc7s7RNU_1746123184
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 1 May 2025 at 17:51, Steven Rostedt <rostedt@goodmis.org> wrote:
> I just noticed that this patch was never applied. Is it still something t=
o add?
No, it=E2=80=99s no longer needed =E2=80=94 we can drop it.
Costa

