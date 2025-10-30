Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D00340293
	for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Oct 2025 09:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761815455; cv=none; b=ZUqP7y3sZeuPtCbVvGRZIEbanz5LkLLP3VSUntxzJlFGOeEnys/KRndjyTfh1/QuAfN7Qvv/vJlvLX8BOwDn9QWuFMTsWshNM18b5ZuVzhByNkbuThokJIclD3shUT5Tvgkq9sPlyT34ugDRjXCx6jkvBv0sWQtodAQvI08Kujw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761815455; c=relaxed/simple;
	bh=troghh+EtnIk9h397iUL1P5hBgqhBFYUDWJNFG20LX4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N4/RHOeYDcrrl2Tqp2EVWqqTbI/tF980lyUe/76U0zCpDV+gzkQ0KcNI14294ypTqd4UZPOtBDlSeOye/thNzt+y1x+wc/4xKio6HdldqtqCh+3VLqO+lVDng0CB9a/BxMo7O9XQDVaLPVpNiSsk6mBnf0r4nBte/KYBMLzr46o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aJgg06X2; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aJgg06X2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761815451;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oMeWelBTpKLjORlzb8BUx/v9zk9wij4ZcdP7B2QI6to=;
	b=aJgg06X28JcS+mdgjINFv2nq80B/Iv6fGuUzXJwgJIcREoCkMCMpPmHAu5e2kmAo7X8uNl
	sEUb8OICZ6fUbQwvL+BgGta72iUVRghnZto7MfTtqNCMtXX4n5TJjiBKhXtlpmIFSeImlF
	g24qVi/L/jLG/pzFXl1qkTslCDIOeCw=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-04f2MteqNGK15c2UGehMHA-1; Thu, 30 Oct 2025 05:10:49 -0400
X-MC-Unique: 04f2MteqNGK15c2UGehMHA-1
X-Mimecast-MFC-AGG-ID: 04f2MteqNGK15c2UGehMHA_1761815448
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-59307b95006so406768e87.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 30 Oct 2025 02:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761815448; x=1762420248;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oMeWelBTpKLjORlzb8BUx/v9zk9wij4ZcdP7B2QI6to=;
        b=siCJu06jJzFub+tlRJDzYNlMu5JPPTtjtzs6tbKjFvfxiufFkVe/E2MfkXykurkRKc
         /eupUeXkZ00rW1JEWoQkjHXmURlkPLZnqq73gKFXhsXxwv4dbSAf/26Gd8+gucN7ZCxi
         WpX0jS3Ui89gFL8KMSGVkmJH/ekrrERkj50eUZNQ6ZU7agQyxLwcvICqGz2NPw/31XM5
         55DNxF/0DhdOsYdjX3dujf3GS4n6hsNMReA8oxMQ2VLYzaUHCkWptCjUpoWkTpSopEBT
         ZB40DVzaY3IiUIoSuIHGLz7SZsktwVVIQ8WM/FTkFpcEl80eh9BK0ehcrpPyaX6RcYmJ
         /9+g==
X-Forwarded-Encrypted: i=1; AJvYcCU0PgYgh4GoK+i4P1Yn14EwjNBrDwUIvzVhoYtlFaiAij2hfXg1/7U/LstbLDtqiTZmFmMG8qQOSPp04F8BgHxJFY4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkeLrf0SXOToREP///rc2sAf2M8gbla44Xs8xtZgd51hAxE+3f
	FXZwFUU964NF5r/UHLBkqA1su0EZ5xgHfBIOm/dsOcXsVygUSghiDlnCwqcXUWf8O4Kxm5XFIPy
	++JXzxmYIyz/1uGYz0NpJwW98qWFdtPXZRDOxZTzxnJlq1wdHZiIAgLCYCZmiVVsgkvQocPPKXY
	zfWtL+M049dljWrwFinm5/CDHLHrigpP2TlvLV2ILIa7eEBXMd
X-Gm-Gg: ASbGncsN3Y6oMyefjbnWaPFwbSXyX10Hgfz2hQNsLvV0V3l8ayHi5dcBTiUIF+hrlw3
	RFPxyzkrRrleLw2l3qELPqykV5LhyMga8Bnup39fGZRZP742WiYlM9KQqXlMQjNODmaHq7567Mx
	A2x0esjVD5iQ0JFzkGRvKK1jKsUhbHZsHj8ywSUJqXJi2jMfwB0+ct1g==
X-Received: by 2002:a05:6512:2391:b0:591:d7e1:7859 with SMTP id 2adb3069b0e04-59416ef3b0dmr833630e87.56.1761815448060;
        Thu, 30 Oct 2025 02:10:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGP/kQzE0RNM76fJcR4JF1n9agyalrVPw4P+d/1DyMASGn27+BCcr/ZMHo4k0Nu5jckBVa+UTheLuwKQaCsORU=
X-Received: by 2002:a05:6512:2391:b0:591:d7e1:7859 with SMTP id
 2adb3069b0e04-59416ef3b0dmr833623e87.56.1761815447591; Thu, 30 Oct 2025
 02:10:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002170846.437888-1-costa.shul@redhat.com>
In-Reply-To: <20251002170846.437888-1-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 30 Oct 2025 10:10:36 +0100
X-Gm-Features: AWmQ_bmQbxEjDPYY78CtDBSW88IHSLgudrACU9vS2dpfYk6ZJl9LPEG1O4-mr68
Message-ID: <CAP4=nvTZP+=_hALnW2VB35KWwu5TNJ9m4FS8pLfk3hxFLTTtGg@mail.gmail.com>
Subject: Re: [PATCH v1] tools/rtla: Fix unassigned nr_cpus
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Costa Shulyupin <costa.shul@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	John Kacur <jkacur@redhat.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: FZjhZkia7gHNF4d6GVwpWlLejb6ESahcgXFA4bsEgXY_1761815448
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

=C4=8Dt 2. 10. 2025 v 19:09 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> In recently introduced timerlat_free(),
> the variable 'nr_cpus' is not assigned.
>
> Assign it with sysconf(_SC_NPROCESSORS_CONF) as done elsewhere.
> Remove the culprit: -Wno-maybe-uninitialized. The rest of the
> code is clean.
>
> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  tools/tracing/rtla/Makefile.rtla  | 2 +-
>  tools/tracing/rtla/src/timerlat.c | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>

This is another fix of a bug introduced in the 6.18-v1 RTLA code
consolidation [1], this time affecting the resetting of idle states
set through --deepest-idle-state. Could you please also add it to your
RTLA fix queue?

Also, this should have:

Fixes: 2f3172f9dd58 ("tools/rtla: Consolidate code between
osnoise/timerlat and hist/top")

[1] https://lore.kernel.org/linux-trace-kernel/20250907022325.243930-1-crwo=
od@redhat.com/T/

Thanks,
Tomas

