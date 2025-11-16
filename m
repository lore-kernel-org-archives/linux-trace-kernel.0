Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6005027FB34
	for <linux-trace-kernel@vger.kernel.org>; Sun, 16 Nov 2025 08:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763280717; cv=none; b=l50T8F5RQZaJ9xFrMPWaISdciXV9Mbr+XTUPbzx8/oN1QMtjwnJ0cK5aM3n6SlEzD5THoDU7XpPKYV/c8+78KEeh3cJ91gUFsUsoxwcleJEk0WXGxjFI7/RW72MyTBY8KtUVvV/ZkQuD3rkyEwMSGDRSodvRobgvmYWVIH72UBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763280717; c=relaxed/simple;
	bh=4jwDEm2sAyYHKu+zGh5hRNHcB8FQ+DLUM7X5j7Jlq5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpEJm0ZX0faIXtaKEpl26wcid8jeNdWK/psQzyULdY4XQEf3kZHgXtHJRXnyFFah7ptauZJb34Z/EwdZ2vnNf0SPRhjC8n9JD/9lsnVsAwX5M10+cHELjiq/jaZfp/pplTk4fet9xln1WnuAYwntB3cpUt2t03Zy7UsDEcGLOQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=cbzwDDRp; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="cbzwDDRp"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2984dfae043so29865695ad.0
        for <linux-trace-kernel@vger.kernel.org>; Sun, 16 Nov 2025 00:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1763280714; x=1763885514; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HxFwg3ju+ftuSMqIiYAdOOvZ0OAIJu2EJhRRFE1j4DA=;
        b=cbzwDDRpkw3DgAJ3PaSrTatxTwbDkfkdswhBitGYCpQlycV6H62giabeUcmpEZdd0/
         GHsK/NQUeUOOnvuXK8Qanh9NY9E+0qjtAXW4WUejYI5Bz4eFZKZwhzRVqnD7u4RbSeJQ
         HB5Hm03mGZYK13pfL4ayd6Rw5Ni+OFxI7eVdF+ZHsEeb0yhOwQweDqvjqArD7YTXClsc
         fxPRjT0QP1cFhaWQMVNXMWcto4SY1t2lIPBeE5dYff6RUBWoX2k1ifkP6elRzlhEyKah
         cJrbTTWiCA8RQmQ2OCAAv4hY0l/ylzAJmv4Dk+rVTE7/JHheEZ0f62/XuETG1I5c8ezD
         ywwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763280714; x=1763885514;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HxFwg3ju+ftuSMqIiYAdOOvZ0OAIJu2EJhRRFE1j4DA=;
        b=gtX3e2jbRWJAYIMLZCO4ynj1+VJ/hY+RxmpmGK926NmHtx+Xm1T9sGt6zqwp0ouJDx
         R97l8SICVtqiC0seiEUoFvFozT3QXL2N+gx81NX6W5wDefG+xk5cTuFMQ8jFP38+wn8h
         ULs1m2nbdKKmKtT0J9YbfKD21jyFhzZyLv2LWJYAMGVBfWb2bK6fUDOU66tyF+VSIp9b
         SWbXchYOg6mBDNbO7ynNmfZu71uJSLHMbHI8DFqwFdzq6jswl2GzBPi8KWHX/5NELOjw
         1zcMRNANcd5RYD30cH8tj/ixe9+ictGM9M6W7i0zoudVLHA914AwSn75+8kDh/votQvp
         F2dg==
X-Forwarded-Encrypted: i=1; AJvYcCXODP576EzwHQVAO/OWpV4M4USpO+PpxFwfoC7AubodJgnTZAbLCe4Kbz7kn2g0TPpUksFX/YI5/VQTJ6WYOBGM1rw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVQBREnOs2aLvYZozIsp0tqSR7N5b5V4MKSni3fqnHE84zN+p4
	d98hFo+Ug49x8QMip6x8Aic0bMxBHmrLiSd/5X0L/HlZCTJu/l2RqqBkDtycQVK4GZ8=
X-Gm-Gg: ASbGncu1muHiSc3EUZDtSvOHC59SCek43Neo1u4ibl3gs8guUQh9F7IZflR7ZWRsqNp
	xclB/dbwDpxLESbzZV2rzB1cy37wZqM0abJ09djauLI/grB1xLchFRL4S7JLkkQiXhcGNp1r/nN
	44t2meKVV+q0laG9gKJNPbnZZEqXLAmmhDlwAm/kq5WLqalFk+lLavsjM4wO3TatErYe/dJ8yiS
	g4Asj3XVUTNlsTtrA/+KuBw+OUKO76rji6m2GJJGGwVYZS6M0LG8FtY/kKiwXPCl38FaIfGKepL
	q7iKyXE/zY5gVHCi7/WzI3I3njlq1MP4ryJTfYYhob6SQv3Gj7jTb3RePoPnrggBFcDk0BgpjFC
	iyUcfjQWyhKqwd+B/a5ZzeJvK3+8fIfAMIZ7YD6oF+oGvabseQ/C+wS557P9uz5O/WZ2j4xGXpE
	UT1KF99FWdlBGrrrVZwKEAodZ+2t9goYOEswWOAYSPXA9BO6BMxbc=
X-Google-Smtp-Source: AGHT+IG4zTCgOyc8q36N6azv8U3/msRqtiTIPYqJrKFmmGWBG01OEhj/Rfjn+kBTPtApfo/xiU3cYQ==
X-Received: by 2002:a17:903:230a:b0:295:94e1:91da with SMTP id d9443c01a7336-2986a73b093mr100196375ad.33.1763280714289;
        Sun, 16 Nov 2025 00:11:54 -0800 (PST)
Received: from dread.disaster.area (pa49-181-58-136.pa.nsw.optusnet.com.au. [49.181.58.136])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c234726sm104981205ad.8.2025.11.16.00.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Nov 2025 00:11:53 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98.2)
	(envelope-from <david@fromorbit.com>)
	id 1vKXrS-0000000BUZh-0XuM;
	Sun, 16 Nov 2025 19:11:50 +1100
Date: Sun, 16 Nov 2025 19:11:50 +1100
From: Dave Chinner <david@fromorbit.com>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Christoph Hellwig <hch@lst.de>,
	Christian Brauner <brauner@kernel.org>, djwong@kernel.org,
	john.g.garry@oracle.com, tytso@mit.edu, willy@infradead.org,
	dchinner@redhat.com, linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, jack@suse.cz,
	nilay@linux.ibm.com, martin.petersen@oracle.com,
	rostedt@goodmis.org, axboe@kernel.dk, linux-block@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] xfs: single block atomic writes for buffered IO
Message-ID: <aRmHRk7FGD4nCT0s@dread.disaster.area>
References: <cover.1762945505.git.ojaswin@linux.ibm.com>
 <aRUCqA_UpRftbgce@dread.disaster.area>
 <20251113052337.GA28533@lst.de>
 <87frai8p46.ritesh.list@gmail.com>
 <aRWzq_LpoJHwfYli@dread.disaster.area>
 <aRb0WQJi4rQQ-Zmo@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRb0WQJi4rQQ-Zmo@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>

On Fri, Nov 14, 2025 at 02:50:25PM +0530, Ojaswin Mujoo wrote:
> On Thu, Nov 13, 2025 at 09:32:11PM +1100, Dave Chinner wrote:
> > On Thu, Nov 13, 2025 at 11:12:49AM +0530, Ritesh Harjani wrote:
> > > Christoph Hellwig <hch@lst.de> writes:
> > > 
> > > > On Thu, Nov 13, 2025 at 08:56:56AM +1100, Dave Chinner wrote:
> > > >> On Wed, Nov 12, 2025 at 04:36:03PM +0530, Ojaswin Mujoo wrote:
> > > >> > This patch adds support to perform single block RWF_ATOMIC writes for
> > > >> > iomap xfs buffered IO. This builds upon the inital RFC shared by John
> > > >> > Garry last year [1]. Most of the details are present in the respective 
> > > >> > commit messages but I'd mention some of the design points below:
> > > >> 
> > > >> What is the use case for this functionality? i.e. what is the
> > > >> reason for adding all this complexity?
> > > >
> > > > Seconded.  The atomic code has a lot of complexity, and further mixing
> > > > it with buffered I/O makes this even worse.  We'd need a really important
> > > > use case to even consider it.
> > > 
> > > I agree this should have been in the cover letter itself. 
> > > 
> > > I believe the reason for adding this functionality was also discussed at
> > > LSFMM too...  
> > > 
> > > For e.g. https://lwn.net/Articles/974578/ goes in depth and talks about
> > > Postgres folks looking for this, since PostgreSQL databases uses
> > > buffered I/O for their database writes.
> > 
> > Pointing at a discussion about how "this application has some ideas
> > on how it can maybe use it someday in the future" isn't a
> > particularly good justification. This still sounds more like a
> > research project than something a production system needs right now.
> 
> Hi Dave, Christoph,
> 
> There were some discussions around use cases for buffered atomic writes
> in the previous LSFMM covered by LWN here [1]. AFAIK, there are 
> databases that recommend/prefer buffered IO over direct IO. As mentioned
> in the article, MongoDB being one that supports both but recommends
> buffered IO. Further, many DBs support both direct IO and buffered IO
> well and it may not be fair to force them to stick to direct IO to get
> the benefits of atomic writes.
> 
> [1] https://lwn.net/Articles/1016015/

You are quoting a discussion about atomic writes that was
held without any XFS developers present. Given how XFS has driven
atomic write functionality so far, XFS developers might have some
..... opinions about how buffered atomic writes in XFS...

Indeed, go back to the 2024 buffered atomic IO LSFMM discussion,
where there were XFS developers present. That's the discussion that
Ritesh referenced, so you should be aware of it.

https://lwn.net/Articles/974578/

Back then I talked about how atomic writes made no sense as
-writeback IO- given the massive window for anything else to modify
the data in the page cache. There is no guarantee that what the
application wrote in the syscall is what gets written to disk with
writeback IO. i.e. anything that can access the page cache can
"tear" application data that is staged as "atomic data" for later
writeback.

IOWs, the concept of atomic writes for writeback IO makes almost no
sense at all - dirty data at rest in the page cache is not protected
against 3rd party access or modification. The "atomic data IO"
semantics can only exist in the submitting IO context where
exclusive access to the user data can be guaranteed.

IMO, the only way semantics that makes sense for buffered atomic
writes through the page cache is write-through IO. The "atomic"
context is related directly to user data provided at IO submission,
and so IO submitted must guarantee exactly that data is being
written to disk in that IO.

IOWs, we have to guarantee exclusive access between the data copy-in
and the pages being marked for writeback. The mapping needs to be
marked as using stable pages to prevent anyone else changing the
cached data whilst it has an atomic IO pending on it.

That means folios covering atomic IO ranges do not sit in the page
cache in a dirty state - they *must* immediately transition to the
writeback state before the folio is unlocked so that *nothing else
can modify them* before the physical REQ_ATOMIC IO is submitted and
completed.

If we've got the folios marked as writeback, we can pack them
immediately into a bio and submit the IO (e.g. via the iomap DIO
code). There is no need to involve the buffered IO writeback path
here; we've already got the folios at hand and in the right state
for IO. Once the IO is done, we end writeback on them and they
remain clean in the page caceh for anyone else to access and
modify...

This gives us the same physical IO semantics for buffered and direct
atomic IO, and it allows the same software fallbacks for larger IO
to be used as well.

> > Why didn't you use the existing COW buffered write IO path to
> > implement atomic semantics for buffered writes? The XFS
> > functionality is already all there, and it doesn't require any
> > changes to the page cache or iomap to support...
> 
> This patch set focuses on HW accelerated single block atomic writes with
> buffered IO, to get some early reviews on the core design.

What hardware acceleration? Hardware atomic writes are do not make
IO faster; they only change IO failure semantics in certain corner
cases. Making buffered writeback IO use REQ_ATOMIC does not change
the failure semantics of buffered writeback from the point of view
of an application; the applicaiton still has no idea just how much
data or what files lost data whent eh system crashes.

Further, writeback does not retain application write ordering, so
the application also has no control over the order that structured
data is updated on physical media.  Hence if the application needs
specific IO ordering for crash recovery (e.g. to avoid using a WAL)
it cannot use background buffered writeback for atomic writes
because that does not guarantee ordering.

What happens when you do two atomic buffered writes to the same file
range? The second on hits the page cache, so now the crash recovery
semantic is no longer "old or new", it's "some random older version
or new". If the application rewrites a range frequently enough,
on-disk updates could skip dozens of versions between "old" and
"new", whilst other ranges of the file move one version at a time.
The application has -zero control- of this behaviour because it is
background writeback that determines when something gets written to
disk, not the application.

IOWs, the only way to guarantee single version "old or new" atomic
buffered overwrites for any given write would be to force flushing
of the data post-write() completion.  That means either O_DSYNC,
fdatasync() or sync_file_range(). And this turns the atomic writes
into -write-through- IO, not write back IO...

> Just like we did for direct IO atomic writes, the software fallback with
> COW and multi block support can be added eventually.

If the reason for this functionality is "maybe someone
can use it in future", then you're not implementing this
functionality to optimise an existing workload. It's a research
project looking for a user.

Work with the database engineers to build a buffered atomic write
based engine that implements atomic writes with RWF_DSYNC.
Make it work, and optimise it to be competitive with existing
database engines, than then show how much faster it is using
RWF_ATOMIC buffered writes.

Alternatively - write an algorithm that assumes the filesystem is
using COW for overwrites, and optimise the data integrity algorithm
based on this knowledge. e.g. use always-cow mode on XFS, or just
optimise for normal bcachefs or btrfs buffered writes. Use O_DSYNC
when completion to submission ordering is required. Now you have
an application algorithm that is optimised for old-or-new behaviour,
and that can then be acclerated on overwrite-in-place capable
filesystems by using a direct-to-hw REQ_ATOMIC overwrite to provide
old-or-new semantics instead of using COW.

Yes, there are corner cases - partial writeback, fragmented files,
etc - where data will a mix of old and new when using COW without
RWF_DSYNC.  Those are the the cases that RWF_ATOMIC needs to
mitigate, but we don't need whacky page cache and writeback stuff to
implement RWF_ATOMIC semantics in COW capable filesystems.

i.e. enhance the applicaitons to take advantage of native COW
old-or-new data semantics for buffered writes, then we can look at
direct-to-hw fast paths to optimise those algorithms.

Trying to go direct-to-hw first without having any clue of how
applications are going to use such functionality is backwards.
Design the applicaiton level code that needs highly performant
old-or-new buffered write guarantees, then we can optimise the data
paths for it...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
