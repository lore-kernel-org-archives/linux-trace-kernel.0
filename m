Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B6F382
	for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Dec 2024 07:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735370958; cv=none; b=R7LT6nyv2MplCWeV7z89PfTApL7+Fpv76Zx+mWmDNoQf6+jO5VQvRCX9q/TvTPaHtoqa+cBcnLjXtBF6D6CJzJ2APeNvk1LYq0S3S1KMilqWNTdk0jn41ZyKQKvSiqHsypBjL3R9ZrZZZgoik20ZLiT+RFhoGGW99RxlOV1hOXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735370958; c=relaxed/simple;
	bh=wX6FJJa2glmzxP1IAk9trACuCKcfPIwmpTan7nq1xgA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=pv0wXKfUxV/Px7PWPJh11tlsj2qduHdMkZBE5Rv/ICsDhVsPgZ68+uf3C48RkNpWLQ/hsRH1lpzeX1WtqZ5w309KNWH+ZoRPlrCkps3KBziNanK8YEkGnp8t9yzDcPN37WIk2CPNOz8kfxMQsoNU9XaN2lAz6P/5+AYyhi0y5aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dTFF563X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dTFF563X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1735370954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=koIMOja80+kSoOIfzgE3UPWf/BgXsBcYH0PBi+n1GJQ=;
	b=dTFF563XSfGa3BF7/TFZ4T7CmFPzyZdlmU6rofpRTJay2ng/7pC5zSBh5OclyOqvGOYq/R
	PkuUsxbUO6H/oR4QS5J2k3iGPTBdakExW40B+S+pQCpkLhpApiYMDuxqLQz6C8agWEtWhE
	0/JrCfZV7Cwawxe4+ZNllXZnDHu04wU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-_OdJuuRNMCKOABkuoksyMw-1; Sat, 28 Dec 2024 02:29:13 -0500
X-MC-Unique: _OdJuuRNMCKOABkuoksyMw-1
X-Mimecast-MFC-AGG-ID: _OdJuuRNMCKOABkuoksyMw
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38a35a65575so2581652f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Dec 2024 23:29:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735370952; x=1735975752;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iM4siNB6Cvqu2qhvv0002GIYdyueaZLh5tndYJXy2DI=;
        b=hrOK2qnqgUxIRpPzcxPCGyH8MeI02wo1AfBWfYxx2yfpoF6ehUgQvMb+vv0cEqaDmV
         gSiFBaKd+YauQFSTfojt5TariXmE8FwAyyd2RyBYRKlXJXrU8Q3CtPPbYb/KmgmdGyEW
         3EiA3v15q27TU8E4vYbb/7DbqU5oi7l9yqzcCOhaS95ka9BVmA7bwD/EYKEzankNcEWF
         nk5cs1TF3/EJ2J3I9NsoR5OTRZNKxJRIEeRk0UJEW4MUuKqeO7evvJwnGCL+7x/FpZlI
         gXZ2CG74S2gU198nZ7iywwHwMKTXq6lESCwvxHUQ6aGqjNZ+x2/dtmjrwsEf6VHJVQJK
         wKpQ==
X-Gm-Message-State: AOJu0Yy6Luqhu4kJrDgTS0tXjYu+CpCFC9BdBItXGezuKsJgz06ECl2s
	c4PzEMooVHJj+AryYAbEjjJWt/n7/tGlvOout1dwvqTR5kMPXFdzzQeVZ4QXt0EyuUcrUKw4F2X
	yCkGiOWuEtaagVqyZ5JdDAQoIEvPOnjLq9twZAuihuSAEYItPN8eTel6rCug/XLZXOzR70A==
X-Gm-Gg: ASbGncs3kEkCHCZyjnqi2XELpesblbrcS4AbS7oGI995YL+skXd1MN/sO69Yd+JGj4d
	APnYADLBPhLbKpluHluXFveKzYCK4sQW+ph67h3k31rKcwc5+HuLDId2t9z1enPI2HqpXCtEYfc
	H/oKPGGVuxynkjqNyGM5vx9w8jeINxemijU33yGqS9N7x9GJFhdu1Sotc1q4gs7JPdIK+yhyw9a
	Nq58pcSvk7NfLy0pYHYORLTbK5/v1vRxOx7zLNyjC9BlpphfrLHn0c=
X-Received: by 2002:a5d:584d:0:b0:386:3918:16cd with SMTP id ffacd0b85a97d-38a224034d2mr23614544f8f.59.1735370952340;
        Fri, 27 Dec 2024 23:29:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF6vO82h1FJC8O596rvQ9SR0Xz/9q5dzCeYoUqoyHkPepdetSdqakiEHtKKgRpLEvZ9OGhqIQ==
X-Received: by 2002:a5d:584d:0:b0:386:3918:16cd with SMTP id ffacd0b85a97d-38a224034d2mr23614508f8f.59.1735370951498;
        Fri, 27 Dec 2024 23:29:11 -0800 (PST)
Received: from [127.0.0.1] ([195.174.134.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c828817sm24619482f8f.1.2024.12.27.23.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Dec 2024 23:29:10 -0800 (PST)
Date: Sat, 28 Dec 2024 07:25:36 +0000
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
CC: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 Juri Lelli <juri.lelli@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 John Kacur <jkacur@redhat.com>
Subject: Re: [PATCH 7/8] verification/dot2k: Auto patch current kernel source
User-Agent: Thunderbird for Android
In-Reply-To: <20241227144440.17171185@gandalf.local.home>
References: <20241227144752.362911-1-gmonaco@redhat.com> <20241227144752.362911-8-gmonaco@redhat.com> <20241227144440.17171185@gandalf.local.home>
Message-ID: <DD2FC1E9-94BD-4B66-A4C7-0930DE50E6C7@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EdIJeAo6gQ20REzlISLI2ABhBcLxs2wRh2_BDpGm-AU_1735370952
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Il 27 dicembre 2024 19:44:40 UTC, Steven Rostedt <rostedt@goodmis.org> ha s=
critto:
>On Fri, 27 Dec 2024 15:47:51 +0100
>Gabriele Monaco <gmonaco@redhat.com> wrote:
>
>> dot2k suggests a list of changes to the kernel tree while adding a
>> monitor: edit tracepoints header, Makefile, Kconfig and moving the
>> monitor folder. Those changes can be easily run automatically.
>>=20
>> This patch adds a flag to dot2k to alter the kernel source.
>
>I'll pull in these patches for linux-next, but the above should be written
>as:
>
>  Add a flag to dot2k to alter the kernel source.
>
>I made the update. This is for future reference. Never use "This patch" or
>"This commit" in a change log.
>
>Thanks,
>
>-- Steve
>

Alright, thanks for the note and the fast reply!

Cheers,
Gabriele

>
>>=20
>> The kernel source directory can be either assumed from the PWD, or from
>> the running kernel, if installed.
>> This feature works best if the kernel tree is a git repository, so that
>> its easier to make sure there are no unintended changes.
>>=20
>> The main RV files (e.g. Makefile) have now a comment placeholder that
>> can be useful for manual editing (e.g. to know where to add new
>> monitors) and it is used by the script to append the required lines.
>>=20
>> We also slightly adapt the file handling functions in dot2k: __open_file
>> is now called __read_file and also closes the file before returning the
>> content; __create_file is now a more general __write_file, we no longer
>> return on FileExistsError (not thrown while opening), a new
>> __create_file simply calls __write_file specifying the monitor folder in
>> the path.
>>=20
>> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
>

Gabriele Monaco
Senior Software Engineer - Kernel Real Time
Red Hat

gmonaco@redhat.com

