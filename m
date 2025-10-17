Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F89E2C325D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691014; cv=none; b=aq/HsqfeNlOk2lYOYzmyTtulzc+aGi4Tv2+3DgC+haxutI2Fo21Oj2r3+aiwmI6xzjaM9zYItpkISxZyK/d6bfjw/aVfp68PY3Zq3I5gADjL5ryOdtQyJifZcK+xBdC5zminBLq/pKQCybbhONU0r27ImDCVvJ4InZfHkvQEF90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691014; c=relaxed/simple;
	bh=YYPBQlX7Etpjm7s7QEscaxhTtIcXv6bNblJxH9enR0o=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B0YYS4UpBMkmHN/5EGNmsl7Hj7XzmeeuH9k4EH3pbf1jCEb6b4mpquDe70uxrm9G4dVvEDMg///svLV6jh9TsLsKuWHhZPucslwc5aRAVXoqOuTeYrnJlyk/mJytjrL2KeOTg0pVh2zk2cRvRSUYKP86C3HORb4Oa0DTWsplNKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zl2YTDpy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zl2YTDpy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760691011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zV6AtvlPKGZafx/Nitbtxi83/9doZbaW2tevNb4ppcA=;
	b=Zl2YTDpyjE+qi7yxiZFdlwDdGb5Iw7kLSBvLLXoSl0wUO5p2KNcO0RR7yDR7d8MBLy6tP8
	/Y0NLMH8cC8Ix+8AIyqShWzTWY0wkLieybzY3inA7CwFp+WabBZsx3v/nYYMrVdycCBC3W
	aR2GFm8YXHOmGPGjLKit33kGGlXfZkE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-WPE_9FooMeKb6dFy8V4pKQ-1; Fri, 17 Oct 2025 04:50:09 -0400
X-MC-Unique: WPE_9FooMeKb6dFy8V4pKQ-1
X-Mimecast-MFC-AGG-ID: WPE_9FooMeKb6dFy8V4pKQ_1760691008
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3f7b5c27d41so1053684f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Oct 2025 01:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760691008; x=1761295808;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zV6AtvlPKGZafx/Nitbtxi83/9doZbaW2tevNb4ppcA=;
        b=w6S/hrNWBABb90qPyZmet3iXsZg7s3XNxnPYpgo6vwdI5SrhiZw2oGFDPHDyh0I95i
         wLCWYEeKapRCy7uW8xHhFd5Gjndyt+Tk6zvf/IMgCHRm1QwUff6F8rFbnNPjvFWH2eDh
         fNyDOwZ6NmL3TqIRz63NkvhtZEHZLNH2b2LVtDBNuJITbyYhBpoNP9bOet99SULHSU9u
         wGpWUm5IOeOUHmS+EQ8+AsZrI2w09WRNxP5kK7JAgJzUcPlxq6Z1yEMzMN+hoIn7NWP/
         pBPOrd2KVpisDpxPcALmIgq7IUHPKQSONLfqNoTtItfqzWdLYOvhOK7yxpiYdIa456xD
         gG/A==
X-Forwarded-Encrypted: i=1; AJvYcCUiqqdQITSH6vRaQyRr5XUbPPjZd0tDys/iH/PTi7UzA+n8Syjc8hKwBa0RjfUDuJVhdAIIrNkjUmgDltxGZJVD4xM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLcIRFPE0WBk+InvmoJ+XGIUp+zfpnpHzWRy0R1Ab9LIriRVla
	FxIWGHpXPJeImMQ/+NnjlTqvmaQyl7iqLF4lk/7980FSIQ9KXMI730g0NETBhVgEK4pbn+33qaq
	OWmMuPCxqPBiHHaM5QeN4rplI3tgrei9U2BYIgwH4oSriPsWhQ7+qxoA8FtqRz366FtF3YBeFiQ
	==
X-Gm-Gg: ASbGncv6f5w4DiXzkE0qsfPEeaVWV3sqHMNzxhotqX2XWTcwm74+DjMcQbcnVLAlGhm
	GBb0mvicdx/f3+tfdXxxExIY7qlalHThalcxb7tvMBVK67AdRduVKPwhBPd8GgKrzt+B/S6oEQU
	UjUxIKDSR9A3y6WnD/H6xsNdZIsZP3tdAUTdxbON2OSfaMFJhYsWHC549Jc8Mu482rNKZHsmURM
	yabqrgitEns9RxStRSPTSojOUhkkRjGuvozFH0gMQ4azYjpVJ2OsTbkC9rqv8Bmy5k2MA3Jxd2v
	4FE7SXaMgrifCtJeBADE7I9oJfC/2VMTrQvjruPLv6C0dyyUIofaOWsWSlQJFedPGeXmURzgVoG
	T0UpxDEl+sfvuCWaM+mnrN4Pa
X-Received: by 2002:a05:6000:1a86:b0:407:d776:4434 with SMTP id ffacd0b85a97d-426fb9b5505mr4848410f8f.30.1760691008301;
        Fri, 17 Oct 2025 01:50:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPn1Bq51EEjEp3mbuDuZJdQmHmvxSk92khzwK9w79un3eDQHfNQFRXeoDtb5mSWq1kC9Os9Q==
X-Received: by 2002:a05:6000:1a86:b0:407:d776:4434 with SMTP id ffacd0b85a97d-426fb9b5505mr4848383f8f.30.1760691007930;
        Fri, 17 Oct 2025 01:50:07 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-426ce5cfe4esm38047624f8f.26.2025.10.17.01.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 01:50:07 -0700 (PDT)
Message-ID: <c6b17fa02a82c61a64abaf6c0abb5154f79c4fbf.camel@redhat.com>
Subject: Re: [PATCH 0/2] selftests/verification: Add initial RV tests
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, John Kacur <jkacur@redhat.com>, 
 Waylon Cude <wcude@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 17 Oct 2025 10:50:06 +0200
In-Reply-To: <87o6q6vuyj.fsf@yellow.woof>
References: <20250926094613.34030-1-gmonaco@redhat.com>
	 <87o6q6vuyj.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ixiCvOnvqs3YNxbRV1leeuTyC2jfq_ucGScl885-040_1760691008
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-10-17 at 09:38 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > Add a series of tests to validate the RV tracefs API and basic
> > functionality.
>=20
> Thanks for the writing this test. My bash knowledge is not great, and
> I'm not familiar with the existing ftrace test, so I am not able to
> review all the details. But looks good as far as I can tell:
>=20
> Acked-by: Nam Cao <namcao@linutronix.de>

Thanks for the ack!
I think that's good for now as it's going to go to Steve as a next step any=
way.

I'm going to send a V2 with the following change just to increase the likel=
ihood
of a wwnr reaction and prepare a PR.
I'll keep your ack there unless you explicitly mean otherwise.

Thanks,
Gabriele

diff --git a/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
b/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
index bc0b2668bf7c..5a59432b1d93 100644
--- a/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
+++ b/tools/testing/selftests/verification/test.d/rv_wwnr_printk.tc
@@ -4,9 +4,10 @@
 # requires: available_reactors wwnr:monitor printk:reactor stress-ng:progr=
am
=20
 load() { # returns true if there was a reaction
-       local lines_before
+       local lines_before num
+       num=3D$((($(nproc) + 1) / 2))
        lines_before=3D$(dmesg | wc -l)
-       stress-ng --cpu-sched 2 --timer 2 -t 5 -q
+       stress-ng --cpu-sched "$num" --timer "$num" -t 5 -q
        dmesg | tail -n $((lines_before + 1)) | grep -q "rv: monitor wwnr d=
oes
not allow event"
 }

