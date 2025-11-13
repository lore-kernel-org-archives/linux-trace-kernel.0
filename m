Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4D82FF66A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Nov 2025 05:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763013239; cv=none; b=bdV2DpnmgUh9W5/rRFx0kNOEh7SDdJ3vIjjAEj9y1F1jcWSRfXoxj/vRzgsb3H3VHzeHpv38XzC5Om7DKzF+62XQEUvCa0AJwHCch4NR1913Y6jkNeKWf6FfIG9JDa8aue0KKIY6hhu8epXbbFPlX6cjSa7yuzpsGnRwl2WaeFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763013239; c=relaxed/simple;
	bh=G5i5DL7xw9uVAkYcjg+MHuhn04UdAZgfzYJ3MKANfAw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=CasPIxGt0/jXFPHUqmxUENcuz0ViTmXuQoKjP5IsslV+3pbvK5CsM2Z9QJyZiEkRLTKIDobI9zFp9EUTXrdSdMp5fwNYyWpgsX27FxlLNQuhfNNA2pxhH6SvQCD5nuyROAqCDNjKr358ygQbR6Sbb09Efktlx4nUQfv4rZHhIdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R2VYgd/g; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R2VYgd/g"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7aab061e7cbso432232b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 21:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763013237; x=1763618037; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2UyP0ogKxI9Y1Qsu6mcA+/ZagVf5oyFn5jJYg/5sVy4=;
        b=R2VYgd/gSHShdVYxRp1tmwr1qySTws7MYLV3MWarXUOXzL3OIEjH8caB0NQOWdPYZD
         rI3PEDELbZyWeK8hNOoaFsXuipZ7cUygFQhnburJc/0kXmYkgHkTGng8bR8SBHOCJj4E
         53fFaNXd2UkmKbycleogi0lqdBIGUfboc0LRIWEsaZ9Oh0wvWlt8hscCEmIncrfv1W0c
         kZCvsqDmdF9hsYo9Ktk8Hrozc8ik0cPhfTAYrszTmXMWzfB+v9LtAeLW9mh5wbGMVKe+
         RhWd8Gl2Gs+A3e0gB5cLb9fUP77n32C7fyxbKmkblnInmAdmF4ZwCtQs09PbiAaYjm/G
         KNFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763013237; x=1763618037;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2UyP0ogKxI9Y1Qsu6mcA+/ZagVf5oyFn5jJYg/5sVy4=;
        b=SdPwzm179odQ4ZPoPizZdB3nzI3EEYDjKveUvzcviHUJK4LaYLwb4yMtUILixA7Vgd
         Q6g95UipFeiWxU0nbGNJA4TGys3n3gijk38pchbPTaV0QhPvddg5zeHvrClE/ufv4S2c
         EKL6a10V+jkoZL8hAwwF3K3rsXU1IpOwZEiy/+LlcVQOg+5b8J4gATazQZE3CbJ+mhvr
         9KSdSMdRqUVFNP3WAc/O/b2Noe5kVX+/mfOFSdRGJr9PB4jdk/y6R9Ud4921JhN0Zy3q
         6bOCLhiE/Slgq90sEkBa1S9WNOmSauXOeNUGR+0wFmp1YbRJrPvO1ErstQvBw6ZdcRPT
         5wnA==
X-Forwarded-Encrypted: i=1; AJvYcCVKyoOJEWV3TZQhS7y+ve8Jexp6bPh5bQszoKR+iFH6OH5rzJXok4edMOjrlg244zx57COoIuWGyIxORieLHD4qTaE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPOmgANQTrKxTh71midWHYrluueZPf6uqAUvsPiMAuKpzFDlWV
	Br/fjXKhYlmx3PI5pJ6W3hBvbWZYn2ofvJDgGcbeQOH9FciG24FyJmjeEbdJA3Y2
X-Gm-Gg: ASbGncuR+IT6cqCzst7aqkeC22JMpF+qmBNkxtqBhHCFKYhnwLIafR4DZnKzb5WpfJD
	inBkFNNTClMqcLV/SUHZGh8KyjYxFG6xcyjaUSU5nXWEATYUkiIUOH+j157MRBCsHmEurJvurc6
	1dwHhNA3vNeVBWEeuzAgzm06vo9e/+vmNtiQMV4qBSi8WMEry9M9f1s85STnAvwNibnS+a8VJb0
	Jjj2GNheTWjptqTwbxHB+kNXqbLJo/NP4pvldvZx3WfMz5wN42ZKMwQMeNIIDmKPXKXmJCLI1CR
	LvXLn2LV9d2lj0iml9DoMbkgVX9aF/Cv6Dc/0zakOcokVpJk+/8tA/lWpiVaXwaauYIzWnw3a2o
	VH9/N7+j9J3sTYK/9TtnMYaDVqWRkbLCj6wEx6zAQ//ZWny6TP3Y5VGipXpYSobAqDKMrplo=
X-Google-Smtp-Source: AGHT+IFlsnZ0k8muJSrddDRx8GFRERSbeF4nDY6yspGg9WIg4wg50amrL5Z1QtXjRUhp3wNQXmZujQ==
X-Received: by 2002:a05:6a20:3d89:b0:2ef:1d19:3d3 with SMTP id adf61e73a8af0-3590968f3ffmr7213716637.14.1763013237233;
        Wed, 12 Nov 2025 21:53:57 -0800 (PST)
Received: from dw-tp ([49.207.219.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bc365da0191sm937384a12.0.2025.11.12.21.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 21:53:56 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Christoph Hellwig <hch@lst.de>, Dave Chinner <david@fromorbit.com>
Cc: Ojaswin Mujoo <ojaswin@linux.ibm.com>, Christian Brauner <brauner@kernel.org>, djwong@kernel.org, john.g.garry@oracle.com, tytso@mit.edu, willy@infradead.org, dchinner@redhat.com, hch@lst.de, linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz, nilay@linux.ibm.com, martin.petersen@oracle.com, rostedt@goodmis.org, axboe@kernel.dk, linux-block@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] xfs: single block atomic writes for buffered IO
In-Reply-To: <20251113052337.GA28533@lst.de>
Date: Thu, 13 Nov 2025 11:12:49 +0530
Message-ID: <87frai8p46.ritesh.list@gmail.com>
References: <cover.1762945505.git.ojaswin@linux.ibm.com> <aRUCqA_UpRftbgce@dread.disaster.area> <20251113052337.GA28533@lst.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Christoph Hellwig <hch@lst.de> writes:

> On Thu, Nov 13, 2025 at 08:56:56AM +1100, Dave Chinner wrote:
>> On Wed, Nov 12, 2025 at 04:36:03PM +0530, Ojaswin Mujoo wrote:
>> > This patch adds support to perform single block RWF_ATOMIC writes for
>> > iomap xfs buffered IO. This builds upon the inital RFC shared by John
>> > Garry last year [1]. Most of the details are present in the respective 
>> > commit messages but I'd mention some of the design points below:
>> 
>> What is the use case for this functionality? i.e. what is the
>> reason for adding all this complexity?
>
> Seconded.  The atomic code has a lot of complexity, and further mixing
> it with buffered I/O makes this even worse.  We'd need a really important
> use case to even consider it.

I agree this should have been in the cover letter itself. 

I believe the reason for adding this functionality was also discussed at
LSFMM too...  

For e.g. https://lwn.net/Articles/974578/ goes in depth and talks about
Postgres folks looking for this, since PostgreSQL databases uses
buffered I/O for their database writes.

-ritesh
