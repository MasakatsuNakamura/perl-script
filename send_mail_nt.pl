#!/usr/local/bin/perl -w
use Net::SMTP;

$smtp = Net::SMTP->new('10.36.18.14');

$smtp->mail("nakamura-m\@ns1.nara.sharp.co.jp");
$smtp->to("nakamura-m\@ns1.nara.sharp.co.jp");

$smtp->data();
$smtp->datasend("From: nakamura-m\@ns1.nara.sharp.co.jp\n");
$smtp->datasend("To: nakamura-m\@ns1.nara.sharp.co.jp\n");
$smtp->datasend("Subject: test mail\n");
$smtp->datasend("\n");
$smtp->datasend("A simple test message\n");
$smtp->dataend();

$smtp->quit;
